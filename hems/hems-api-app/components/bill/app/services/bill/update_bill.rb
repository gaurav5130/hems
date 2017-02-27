module Bill
	class UpdateBill < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations

		attribute :bill_number, String
		attribute :items_discount, Array
		attribute :bill_discount, Hash

		validates :bill_number, presence: true
		# validates :items_discount, presence: true
		# validates :bill_discount, presence: true

		def validate
			if !(valid?)
				return Core::ServiceError.new("Mandatory fields not available")
			end
			return Core::ServiceSuccess.new
		end

		def process
			@bill_header = BillHeader.where(corporate_id: @context.corporate_id,establishment_id: @context.establishment_id,bill_number: @bill_number).first
			@bill_details = BillDetail.where(corporate_id: @context.corporate_id,establishment_id: @context.establishment_id,bill_number: @bill_number)
			orderhdr = Order::OrderHeader.where(bill_number: bill_number).first

			############## Creating Order Item VO Array ###################

			bill_result_vo = PrepareBillResult.new
			order_items_arr = []
			@bill_details.each do |item|
				order_item = Order::OrderItemVO.new
				order_item.code = item.item_code
				order_item.title = Items::SalesItemDetail.where(corporate_id: @context.corporate_id,establishment_id: @context.establishment_id,item_code: item.item_code).pluck(:short_name).first
				order_item.quantity = item.quantity
				order_item.published_rate = item.published_rate_per_unit
				order_item.price = item.invoice_amount
				order_item.category = item.item_tax_category_code
				order_item.discount = item.discount
				order_items_arr.push(order_item)
			end
			bill_result_vo.items = order_items_arr
			

			discount_benefit_to_customer = 0
			############## Applying Item Level Discount #################
			# 
			# items_discount.each do |dis_obj|
			# 	bill_result_vo.items.each do |item|
			# 		if dis_obj["code"] == item.code
			# 			if dis_obj["disType"] == "rupee"
			# 				item.discount = dis_obj["discount"]
			# 				item.price -= dis_obj["discount"].to_f
			# 			elsif dis_obj["disType"] == "percentage"
			# 				item.discount = (dis_obj["discount"] * item.price)/100
			# 				item.price -= item.discount
			# 			end
			# 			discount_benefit_to_customer += item.discount
			# 			if item.price < 0
			# 				# return error 
			# 			end 
			# 		end
			# 	end
			# end
			# p "After Item level Discount"
			# pp bill_result_vo
			############## Applying Bill Level Discount #################

			published_amt = @bill_header.total_published_amount
			if bill_discount.length > 0
				if bill_discount["disType"] == "RUPEE"
					disc_pct = (bill_discount["discount"].to_f * 100)/@bill_header.total_payable.to_f
				elsif bill_discount["disType"] == "PERCENTAGE"
					disc_pct = bill_discount["discount"].to_f
				end
				bill_result_vo.items.each do |item|
					item.discount += (disc_pct.to_f * item.price.to_f)/100
					item.price -= (disc_pct.to_f * item.price.to_f)/100
					if item.price < 0
						# return error
					end
				end
				discount_benefit_to_customer = (disc_pct.to_f * @bill_header.total_payable.to_f)/100
			end
			p "After Bill level Discount"
			pp bill_result_vo

			############## Grouping Items by Tax Category #################
			order_category_list = []
			facility_code = @bill_header.facility_code
			bill_result_vo.items.each do |item|
				item_matched = 0
				order_category_list.each do |cat_item|
					if cat_item.item_category == item.category
						item_matched = 1
						cat_item.category_total += item.price
						break
					end
				end
				if item_matched == 0
					tax_code = Facility::FacilityTaxCodeMapping.where(facility_code: facility_code,item_tax_category_code: item.category).pluck(:tax_code).first
					obj = Order::OrderItemCategoryVO.new(facility_id: facility_code, item_category: item.category, 
						category_total: item.price, tax_code: tax_code)
					order_category_list << obj
				end
			end
			p "Order Category List"
			pp order_category_list

			############## Computing Charge and Tax #################
			chargetax_result = TaxCharge::ComputeChargeTax.call(@context, facility_id: facility_code, order_category_list: order_category_list)
			bill_result_vo.charges = chargetax_result.charges
			bill_result_vo.taxes = chargetax_result.taxes
			p "Final Bill Result VO"
			pp bill_result_vo

			CreateBill.call(@context, facility_code: facility_code, bill_result: bill_result_vo, gross_total: "not using this crap will remove it", order: orderhdr, bill_number: bill_number,discount_benefit_to_customer: discount_benefit_to_customer)
		end
	end
end
