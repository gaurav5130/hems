module Core
  class ApplicationController < ActionController::Base
  	include Pundit

    helper_method :set_access_context

    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :set_context, unless: :devise_controller?
    #before_action :authorize_user, unless: :devise_controller?

    attr_reader :context

    def pundit_user
      AccessContext.new(set_access_context)
    end

    private

    def set_context
      unless current_user
        #TODO - raise error
      end

    	@context = ContextVO.new(current_user.corporate_id, current_user.establishment_id)
    end

    def set_access_context
      data = Hash.new
      data[:user] = current_user
      data[:action] = params[:action]
      data[:access_key] = params[:_access]
      data[:context] = @context

      data
    end

    def authorize_user
      authorize :access, :check?
    end
  end
end