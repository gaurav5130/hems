module Reference
	class FetchRefHeader < Core::BaseService
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
				header = Metamodel::Reference::RefHeader.where(ref_type: @ref_type)
				if header.empty?
					err = Core::ServiceError.new("#{@ref_type} data is not available")
					err.status(406)
					return err
				else
					success_obj = Core::ServiceSuccess.new
					success_obj.status(200)
					success_obj.data(header[0])
					return success_obj	
				end
			rescue
				err = Core::ServiceError.new("Some Internal Error")
				err.status(500)
				return err
			end
		end
	end
end