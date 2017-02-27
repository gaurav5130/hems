module Bill
	class PrepareResponse < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations
		
		attribute :bill_number, String
		validates :bill_number, presence: true

		def validate
			if !(valid?)
				return Core::ServiceError.new("Bill Number is not available")
			end
			return Core::ServiceSuccess.new
		end

		def process
			header = BillHeader.where(bill_number: bill_number).first
			details = BillDetail.where(bill_number: bill_number)

			response = Hash.new
			response["context"] = @context
			response["bill_number"] = header.bill_number
			response["bill_date"] = header.bill_date
			response["steward"] = header.steward
			response["waitor"] = header.waitor
			response["member_id"] = header.member_id
			response["items"] = []
			details.each do |item|
				new_item = Hash.new
				new_item["code"] = item.item_code
				new_item["title"] = item.item_name
				new_item["quantity"] = item.quantity
				new_item["rate_per_unit"] = item.published_rate_per_unit
				new_item["discount"] = item.discount
				new_item["invoice_amount"] = item.invoice_amount
				response["items"].push(new_item)
			end
			response["total_published_amount"] = header.total_published_amount
			response["discount_benefit_to_customer"] = header.discount_benefit_to_customer
			response["total_invoice_amount"] = header.total_invoice_amount
			response["total_charges"] = header.total_charges
			response["total_taxes"] = header.total_taxes
			response["total_payable"] = header.total_payable
			response["amount_collected"] = header.amount_collected

			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data(response)
			return success_obj
		end
	end
end
