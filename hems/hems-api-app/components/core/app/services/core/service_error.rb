module Core
	class ServiceError
		attr_reader :error, :status

		#TODO - Handling JSON Return Data for Errors
		
		def initialize error
			#TODO - Definition of error list
			@error = {"error"=>error}
		end

		def success?
			false
		end

		def status code
			@status = code
		end

		def status?
			@status
		end
	end
end