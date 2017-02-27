module Reference
	class FetchRefFieldList < Core::BaseService
		#Initialization of this service

		include ActiveModel::Validations
		include Virtus.model

		attribute :ref_type, String

		def initialize ref_type
			@ref_type = ref_type
		end

		validates :ref_type, presence: true

		private

		#Static and business validations of this service
		def validate
			if !(valid?)
				return Core::ServiceError.new("Mandatory fields not available")
			end
			return Core::ServiceSuccess.new
		end

		#Process logic of this service
		def process
			begin
				@default_fields = Metamodel::Reference::RefFields.where(ref_type: "default_type")
				@extra_fields = Metamodel::Reference::RefFields.where(ref_type: @ref_type)
				success_obj = Core::ServiceSuccess.new
				success_obj.status(200)
				success_obj.data(merge_fields)
				return success_obj
			rescue
				err = Core::ServiceError.new("Some Internal Error")
				err.status(500)
				return err
			end
		end

		private 

		def merge_fields
			remove_fields = Array.new
			@extra_fields.each do |extra_field|
				if extra_field.is_additional == false
					@default_fields.each do |default_field|
						if default_field.fld_name == extra_field.fld_name
							remove_fields.push(default_field)
						end
					end
				end
			end
			@default_fields + @extra_fields - remove_fields
		end
	end
end