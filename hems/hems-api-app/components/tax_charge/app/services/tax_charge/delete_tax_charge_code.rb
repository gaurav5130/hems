module TaxCharge
	class DeleteTaxChargeCode < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations

		attribute :id, Integer
		

		validates :id, presence: true

		private
		def initialize(params)
			@id=params[:id]
		end
		#Static and business validations of this service
		def validate()
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new		
		end
		
		#Process logic of this service
		def process()
			obj=TaxChargeCodeDefinition.where(id: @id, corporate_id: @context.corporate_id).delete_all
			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data({"msg": "Code Deleted"})
			success_obj
		end
	end
end