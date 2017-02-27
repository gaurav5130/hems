module Facility
	class UpdateFacilityItem < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations
		attribute :facility_code, String
		attribute :item_code, String
		attribute :published_rate, Float
		attribute :id, Integer

		validates :facility_code, presence: true
		validates :id, presence: true
		validates :item_code, presence: true
		validates :published_rate, presence: true

		#Initialization of this service
		def initialize(params)
			@id=params[:id]
	      	@facility_code=params[:facility_code]
		  	@item_code=params[:item_code]
			@published_rate=params[:published_rate]
		end
		
		def validate
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new		
		end

		def process
			item_facility_mapping=FacilityItemMapping.where(id: @id, corporate_id: @context.corporate_id, establishment_id: @context.establishment_id).first

			item_facility_mapping.facility_code=@facility_code
			item_facility_mapping.item_code=@item_code
			item_facility_mapping.published_rate=@published_rate
			item_facility_mapping.updated_at=DateTime.now
			item_facility_mapping.save!
			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data({"msg": "Code Updated"})
			success_obj
		end
	end
end