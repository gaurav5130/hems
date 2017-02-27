module Reference
	class FetchRefCode < Core::BaseService
		#Initialization of this service

		include ActiveModel::Validations
		include Virtus.model

		attribute :id, Integer
		attribute :ref_type, String

		def initialize id , ref_type
			@id = id
			@ref_type = ref_type
		end

		validates :id, presence: true
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
				code = RefCodes.where(id: @id, ref_type: @ref_type).select("id","code","desc","alt_desc","short_desc","additional_data")
				if code.empty?
					error_obj = Core::ServiceError.new("#{@ref_type} codes are not available")
					error_obj.status(406)
					return error_obj
				else
					success_obj = Core::ServiceSuccess.new
					success_obj.status(200)
					success_obj.data(code[0])
					return success_obj		
				end
			rescue
				error_obj = Core::ServiceError.new("Some Internal Error")
				error_obj.status(500)
				return error_obj
			end
		end
	end
end