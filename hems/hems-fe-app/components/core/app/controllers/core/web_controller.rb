module Core
  class WebController < ApplicationController
    layout "webui/application"

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def user_not_authorized(exception)
    	mesg = exception.message
    	unless mesg
    		mesg = "You are not authorized to perform this action."
    	end
      	flash[:danger] = mesg
      	redirect_to(home.home_denied_path)
    end
  end
end
