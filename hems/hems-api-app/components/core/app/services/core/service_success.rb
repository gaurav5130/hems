module Core
	class ServiceSuccess
		attr_reader :data
		
		def initialize
		end

		def data data
			@data = data
		end

		def status code
			@status = code
		end

		def data?
			#TODO - Handling JSON Return Data
			@data
		end

		def status?
			@status
		end

		def success?
			true
		end
	end
end
