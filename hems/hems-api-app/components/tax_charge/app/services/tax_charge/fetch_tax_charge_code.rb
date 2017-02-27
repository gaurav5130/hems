module TaxCharge
	class FetchTaxChargeCode< Core::BaseService
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
			obj=TaxChargeCodeDefinition.where(id: @id, corporate_id: @context.corporate_id).first
			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data(obj)
			success_obj
		end
	end
end

