require_dependency "core/application_controller"

module Auth
  class ApplicationController < Core::ApplicationController
  	before_action :configure_permitted_params, if: :devise_controller?
  	before_action :rewrite_params, if: :devise_controller?

  	private

	def configure_permitted_params
		devise_parameter_sanitizer.permit :sign_in, keys: [:corporate_id, :establishment_id, :user_id]
		devise_parameter_sanitizer.permit :account_update, keys: [:user_name, :email]
	end

	def rewrite_params
		if request.params[:user]
			upcase_attrs = ["corporate_id", "establishment_id", "user_id", "user_name"]
			upcase_attrs.each do |attr|
				val = request.params[:user][attr]
				request.params[:user][attr] = val.strip.upcase if !val.nil?
			end
		end
	end
  end
end