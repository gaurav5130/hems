module Facility
	class UpdateFacilityMaster < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations
		attribute :facility_code, String
		attribute :short_desc, String
		attribute :long_desc, String
		attribute :bill_charge_code, String
		attribute :bill_charge_tax_code, String
		attribute :consolidate_tax_for_bill, Boolean
		attribute :id , Integer

		validates :facility_code, presence: true
		validates :id, presence: true
		validates :consolidate_tax_for_bill, presence: true

		#Initialization of this service
		def initialize(params)
			@id=params[:id]
	      	@facility_code=params[:facility_code]
		  	@short_desc=params[:short_desc]
			@long_desc=params[:long_desc]
			@bill_charge_code=params[:bill_charge_code]
			@bill_charge_tax_code=params[:bill_charge_tax_code]
			@consolidate_tax_for_bill=params[:consolidate_tax_for_bill]
		end

		def validate
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new		
		end
				
		private
		
		def process
			facility_master=FacilityMaster.where(id: @id, corporate_id: @context.corporate_id, establishment_id: @context.establishment_id).first
			p facility_master
			facility_master.facility_code=@facility_code
			facility_master.short_desc=@short_desc
			facility_master.long_desc=@long_desc
			facility_master.bill_charge_code=@bill_charge_code
			facility_master.bill_charge_tax_code=@bill_charge_tax_code
			p @consolidate_tax_for_bill
			if @consolidate_tax_for_bill
				facility_master.consolidate_tax_for_bill=true
			else
				facility_master.consolidate_tax_for_bill=false
			end
			facility_master.updated_at=DateTime.now
			facility_master.save!
			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data({"msg": "Code Updated"})
			success_obj
		end
	end
end