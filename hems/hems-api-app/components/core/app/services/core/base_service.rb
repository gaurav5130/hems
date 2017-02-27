module Core
	class BaseService
		def self.call(context, *args)
			obj = new(*args)
			obj.init(context)
			obj.call
		end

		def init(context)
			#TODO - Validation for context
			@context = context
		end

		def call
			result = validate
			if !result.success?
				return result
			end

			process
		end

		def validate
			#TODO - Throw definition error
		end

		def process
			#TODO - Throw definition error
		end
	end
end