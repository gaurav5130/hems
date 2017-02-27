module Bill
	class CreateBill < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations
		
		attribute :facility_code, String
		attribute :bill_result, PrepareBillResult
		attribute :gross_total, Float
		attribute :order, Order::OrderHeader
		attribute :bill_number, String
		attribute :discount_benefit_to_customer, Float

		def validate
			if !(valid?)
				return Core::ServiceError.new("Mandatory fields not available")
			end
			return Core::ServiceSuccess.new
		end

		def process
			begin
				items = bill_result.items
				charges = bill_result.charges
				taxes = bill_result.taxes

				curr_date_time = Time.now
				curr_date = curr_date_time.strftime("%Y-%m-%d")
				curr_time = curr_date_time.strftime("%H:%M:%S")
				if update?
					bill_no = bill_number
					header = BillHeader.where(corporate_id: @context.corporate_id,establishment_id: @context.establishment_id,bill_number: @bill_number).first

					header.discount_benefit_to_customer += discount_benefit_to_customer;
					disc_pct = (discount_benefit_to_customer.to_f / header.total_payable) * 100
					header.total_invoice_amount = header.total_invoice_amount - ((header.total_invoice_amount * disc_pct)/100)
					header.discount_amount = header.total_published_amount - header.total_invoice_amount
					new_total_payable = header.total_invoice_amount + bill_result.charges.tot_amt + bill_result.taxes.tot_amt
					net_payable = header.total_payable - discount_benefit_to_customer
					if net_payable < new_total_payable
						header.discount_round_off = new_total_payable - net_payable
					elsif net_payable > new_total_payable
						header.discount_round_off =  net_payable - new_total_payable
					else
						header.discount_round_off = 0
					end
					header.total_payable = net_payable
				else
					bill_no = create_bill_no @context,"B"
					header = BillHeader.new
					header.bill_number = bill_no
					header.corporate_id = @context.corporate_id
					header.establishment_id = @context.establishment_id
					header.facility_code = @facility_code
					header.order_number = @order.order_number
					header.order_date = curr_date
					header.steward = order.steward
					header.waitor = order.waitor
					header.member_id = order.member_id
					#this has to come from order details

					header.total_published_amount = gross_total
					header.discount_amount = 0
					header.discount_benefit_to_customer = 0
					header.discount_round_off = 0
					header.total_invoice_amount = gross_total
					header.original_total_payable = header.total_payable = gross_total + bill_result.charges.tot_amt + bill_result.taxes.tot_amt

				end
				header.bill_date = curr_date
				header.bill_time = curr_time
				#header.tab_number    
				#header.reservation_id 
				header.total_charges = bill_result.charges.tot_amt
				header.total_taxes = bill_result.taxes.tot_amt
				ActiveRecord::Base.transaction do
					Order::ChangeOrderStatus.call(@context,order_number: order.order_number,bill_number: bill_no,status: "C")
					header.save

					item_count = 1
					bill_result.items.each do |item|
						if update?
							detail = BillDetail.where(corporate_id: @context.corporate_id,establishment_id: @context.establishment_id,bill_number: @bill_number,bill_det_serial_no: item_count).first
						else
							detail = BillDetail.new
							detail.corporate_id = @context.corporate_id
							detail.establishment_id = @context.establishment_id
							detail.bill_number = bill_no						
							detail.bill_det_serial_no = item_count
							detail.item_tax_category_code = item.category
							detail.item_code = item.code
							detail.item_name = item.title
							detail.quantity = item.quantity
							detail.published_rate_per_unit = item.published_rate
							detail.published_rate_total = item.price
						end
						
						detail.bill_date = curr_date
						detail.bill_time = curr_time
						detail.discount = item.discount
						detail.invoice_amount = item.price
						item_count += 1
						detail.save
					end


					if update?
						TaxOnBill.where(corporate_id: @context.corporate_id,establishment_id: @context.establishment_id,bill_number: @bill_number).delete_all
					end
					bill_result.taxes.comp_hash.each do |category,tax|
						tax.comp_list.each do |tax_component|
							tax_on_bill = TaxOnBill.new
							tax_on_bill.corporate_id = @context.corporate_id
							tax_on_bill.establishment_id =  @context.establishment_id
							tax_on_bill.bill_number =  bill_no
							tax_on_bill.bill_date = curr_date
							tax_on_bill.bill_time = curr_time
							tax_on_bill.tax_category_code = category
							tax_on_bill.tax_component_id = tax_component.comp_id
							tax_on_bill.tax_payable = tax_component.calc_amt
							tax_on_bill.tax_serial_no = tax_component.serial_no
							tax_on_bill.save
						end
					end
				end
				return PrepareResponse.call(@context,bill_number: bill_no)
			rescue Exception => e
				p e
			end
		end

		def create_bill_no context,prefix
			(context.establishment_id + prefix +(rand() * 1000).to_i.to_s)
		end

		def update?
			if (bill_number != nil && bill_number != "")
				return true
			else
				return false
			end
		end
	end
end
