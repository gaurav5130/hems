require "devise"
require "auth/engine"

module Auth
	class Engine < ::Rails::Engine
	    config.to_prepare do
	      Devise::SessionsController.layout "webui/login"
	      Devise::RegistrationsController.layout "webui/application"
	    end
	end
end
