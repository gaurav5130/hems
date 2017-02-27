module Bill
	class DeleteBill < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations
		
		attribute :bill_number, String
		validates :bill_number, presence: true

		def validate
			if !(valid?)
				return Core::ServiceError.new("Mandatory fields not available")
			end
			return Core::ServiceSuccess.new
		end

		def process
			ActiveRecord::Base.transaction do
				BillHeader.where(bill_number: bill_number).delete_all
				BillDetail.where(bill_number: bill_number).delete_all
				TaxOnBill.where(bill_number: bill_number).delete_all
				Order::ChangeOrderStatus.call(@context,bill_number: bill_number,status: "O")
			end
			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data({"msg": "Bill Deleted"})
			return success_obj
		end
	end
end

