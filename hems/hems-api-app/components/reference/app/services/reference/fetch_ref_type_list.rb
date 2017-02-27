module Reference
	class FetchRefTypeList < Core::BaseService
		#Initialization of this service
		def initialize
		end

		private

		#Static and business validations of this service
		def validate
			return Core::ServiceSuccess.new
		end
		
		#Process logic of this service
		def process
			begin
				p "undefined method names of nilnil class is comming that's why putting this comment!"
				p "this comment only solves the problem magically"
				header_list = Metamodel::Reference::RefHeader.order(:title)
				success_obj = Core::ServiceSuccess.new
				success_obj.status(200)
				success_obj.data(header_list)
				return success_obj
			rescue => exception
				err = Core::ServiceError.new("Some Internal Error")
				err.status(500)
				return err
			end
		end
	end
end