module TaxCharge
	class UpdateTaxChargeCode< Core::BaseService
		include Virtus.model
		include ActiveModel::Validations
		attribute :code, String
		attribute :component_id, String
		attribute :serial_no, Integer
		attribute :short_name, String
		attribute :long_name, String
		attribute :id	,Integer

		validates :code, presence: true
		validates :id, presence: true
		validates :component_id, presence: true

		#Initialization of this service
		def initialize(params)
			@id=params[:id]
	      	@code=params[:code]
		  	@component_id=params[:component_id]
			@serial_no=params[:serial_no]
			@short_name=params[:short_name]
			@long_name=params[:long_name]
		end
		def validate
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new
		end

		def process
			tax_charge_code_definition=TaxChargeCodeDefinition.where(id: @id, corporate_id: @context.corporate_id).first
			tax_charge_code_definition.code=@code
			tax_charge_code_definition.component_id=@component_id
			tax_charge_code_definition.serial_no=@serial_no
			tax_charge_code_definition.short_name=@short_name
			tax_charge_code_definition.long_name=@long_name
			tax_charge_code_definition.updated_at=DateTime.now
			tax_charge_code_definition.save!

			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data({"msg": "Code Updated"})
			success_obj
		end
	end
end