module Reference
	class UpdateRefCode < Core::BaseService
		#Initialization of this service

		include ActiveModel::Validations
		include Virtus.model

		attribute :ref_type, String
		attribute :id, Integer
		attribute :code, Hash

		def initialize ref_type , id ,code
			@ref_type = ref_type
			@id = id
			@code = code
		end

		validates :ref_type , presence: true
		validates :id , presence: true
		validates :code, presence: true

		private

		#Static and business validations of this service
		def validate
			if !(valid?)
				return Core::ServiceError.new("Mandatory fields not available")
			end

			err_list = []
			fields = get_all_fields
			fields.each do |field|
				@code.each do |key,value|
					if key == "additional_data"
						value.each do |add_key,add_value|
							if (field["fld_name"] == add_key && field["is_additional"] == true)
								if !(validate_data_type(field["fld_type"],add_value))
									err_list << "type not match for field : " + add_key
								end
								if (!validate_data_size(field["fld_size"],add_value))
									err_list << "size error for field : " + add_key
								end
							end
						end
					end

					if (field["fld_name"] == key && field["is_additional"] == false)
						if !(validate_data_type(field["fld_type"],value))
							err_list << "type not match for field : " + key
						end
						if (!validate_data_size(field["fld_size"],value))
							err_list << "size error for field : " + key
						end
					end
				end
			end

			if (err_list.size > 0)
				error_obj =  Core::ServiceError.new(err_list)
				error_obj.status(406)
				return error_obj
			end

			return Core::ServiceSuccess.new
		end

		#Process logic of this service
		def process
			begin
				update_code = RefCodes.find(@id)
				if update_code.ref_type != @ref_type
					error_obj = Core::ServiceError.new("This code is not a part of #{@ref_type}")
					error_obj.status(500)
					return error_obj
				end
				update_code.update_attributes(@code)
				success_obj = Core::ServiceSuccess.new
				success_obj.status(200)
				success_obj.data({"msg": "Code Updated"})
				return success_obj
			rescue
				error_obj = Core::ServiceError.new("Something went wrong")
				error_obj.status(500)
				return error_obj
			end
		end


		private

		def get_all_fields
			default_fields = Metamodel::Reference::RefFields.where(ref_type: "default_type")
			extra_fields = Metamodel::Reference::RefFields.where(ref_type: @ref_type)
			remove_fields = Array.new
			extra_fields.each do |extra_field|
				if extra_field.is_additional == false
					default_fields.each do |default_field|
						if default_field.fld_name == extra_field.fld_name
							remove_fields.push(default_field)
						end
					end
				end
			end
			default_fields + extra_fields - remove_fields
		end

		def validate_data_type type,data
			data_class = data.class
			if type.downcase == "string"
				if data_class == String
					return true
				end
			elsif type.downcase == "integer" || type.downcase == "int"
				if data_class == Fixnum || data_class == Bignum
					return true
				elsif data_class == String
					if data =~ /^[0-9]+$/
						return true
					end
				end
			elsif type.downcase == "float"
				if data_class == Float
					return true
				end
			elsif type.downcase == "boolean"
				if data_class == FalseClass || data_class == TrueClass
					return true
				end
			end
			return false
		end

		def validate_data_size max_size,data
			!(data.length > max_size)
		end
	end
end