module Order
	class ChangeOrderStatus < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations

		attribute :order_number, String
		attribute :status, String
		attribute :bill_number, String

		#validates :order_number, presence: true
		validates :status, presence: true
		
		#Static and business validations of this service
		def validate
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new		
		end
		
		#Process logic of this service
		def process
			if status == "C" || status == "O" || status == "N" || status == "V"
				if status == "O"
					order_headers = OrderHeader.where(bill_number: bill_number)
					order_headers.each do |header|
						header.bill_number = ""
						header.order_status = "O"
						header.save
					end
				elsif status == "C"
					header = OrderHeader.where(order_number: order_number).first
					header.bill_number = bill_number
					header.order_status = "C"
					header.save
				end
			end
		end
	end
end