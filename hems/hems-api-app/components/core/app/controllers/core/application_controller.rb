module Core
  class ApplicationController < ActionController::API
    include ActionController::Helpers
  	include Pundit

  	rescue_from Pundit::NotAuthorizedError, with: :permission_denied
    respond_to :json

    helper_method :set_access_context

    before_action :set_context
    #before_filter :authenticate_request!

    def set_context
      @context = ContextVO.new("C1", "E1")
    end

    protected

    def responder obj
      # render json: '{"error": "error from ctrl"}', status: 500

      if obj.success?
        render json: obj.data?, status: obj.status?
      else
        render json: obj.error, status: obj.status?
      end
    end



    # protect_from_forgery with: :exception
    #before_action :skip_session #This is required as devise is throwing an error
    # before_action :authenticate_user!
    # before_action :set_context, unless: :devise_controller?
    # before_action :authorize_user, unless: :devise_controller?

    attr_reader :context
    attr_reader :current_user

  protected
  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private
  def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end

    def pundit_user
      AccessContext.new(set_access_context)
    end

    private

    ## Skip sessions and cookies for Rails API
    # def skip_session
    #   request.session_options[:skip] = true
    # end

    # def set_context
    #   unless current_user
    #     #TODO - raise error
    #   end

    # 	@context = ContextVO.new(current_user.corporate_id, current_user.establishment_id)
    # end

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

    def permission_denied
    	head 403
    end
  end
end
