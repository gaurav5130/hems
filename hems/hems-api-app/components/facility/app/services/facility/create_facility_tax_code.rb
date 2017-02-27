module Facility
	class CreateFacilityTaxCode < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations
		attribute :facility_code, String
		attribute :item_tax_category_code, String
		attribute :tax_code, String

		validates :facility_code, presence: true
		validates :item_tax_category_code, presence: true
		validates :tax_code, presence: true

		#Initialization of this service
		def initialize(params)
	      	@facility_code=params[:facility_code]
		  	@item_tax_category_code=params[:item_tax_category_code]
			@tax_code=params[:tax_code]
		end
		def validate
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new
		end
		def process
			facility_tax_code_category_mapping=FacilityTaxCodeMapping.new
			facility_tax_code_category_mapping.corporate_id=@context.corporate_id
			facility_tax_code_category_mapping.establishment_id=@context.establishment_id
			facility_tax_code_category_mapping.facility_code=@facility_code
			facility_tax_code_category_mapping.item_tax_category_code=@item_tax_category_code
			facility_tax_code_category_mapping.tax_code=@tax_code

			
			facility_tax_code_category_mapping.created_at=DateTime.now
			facility_tax_code_category_mapping.updated_at=DateTime.now
			facility_tax_code_category_mapping.save!

			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data({"msg": "Code Inserted"})
			success_obj
		end
	end
end