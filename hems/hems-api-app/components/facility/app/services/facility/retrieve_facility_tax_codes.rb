module Facility
	class RetrieveFacilityTaxCodes < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations



		private
		def initialize(params)
			
		end
		#Static and business validations of this service
		def validate
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new		
		end		
		#Process logic of this service
		def process()
			obj=FacilityTaxCodeMapping.all.where(corporate_id: @context.corporate_id, establishment_id: @context.establishment_id)
			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data(obj)
			success_obj
		end
	end
end

