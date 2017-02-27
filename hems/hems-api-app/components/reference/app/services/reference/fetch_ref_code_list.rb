module Reference
	class FetchRefCodeList < Core::BaseService
		#Initialization of this service

		include ActiveModel::Validations
		include Virtus.model

		attribute :ref_type, String

		def initialize params
			@ref_type = params
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
				puts '1'
				code_list = RefCodes.where(ref_type: @ref_type)
				puts '2'
				success_obj = Core::ServiceSuccess.new
				puts '3'
				if code_list
					success_obj.data(code_list)
				end
				success_obj.status(200)				
				return success_obj
			rescue => exception
				pp exception
				err = Core::ServiceError.new("Some Internal Error")
				err.status(500)
				return err
			end
			
		end
	end
end