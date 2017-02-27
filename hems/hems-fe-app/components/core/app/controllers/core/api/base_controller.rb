module Core
  class Api::BaseController < ApplicationController
  	rescue_from Pundit::NotAuthorizedError, with: :permission_denied

	def permission_denied
		head 403
	end
  end
end
