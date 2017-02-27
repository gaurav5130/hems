require_dependency "core/web_controller"

module Admin
  class UserController < Core::WebController
	def index
		#@users = Auth::Users.all#.excludes(:id => current_user.id)
		@users = Auth::Users.apply_context(context)
	end

	def new
		@user = Auth::Users.new
	end

	def create
		@user = Auth::Users.new(user_params)
		if @user.save
			flash[:notice] = "Successfully created User." 
			redirect_to admin_user_index_path
		else
			render :action => 'new'
		end
	end

	def show
		@user = Auth::Users.find(params[:id])
	end

	def edit
		@user = Auth::Users.find(params[:id])
	end

	def update
		@user = Auth::Users.find(params[:id])
		params[:users].delete(:password) if params[:users][:password].blank?
		params[:users].delete(:password_confirmation) if params[:users][:password].blank? and params[:users][:password_confirmation].blank?
		if @user.update_attributes(user_params)
			flash[:notice] = "Successfully updated User."
			redirect_to admin_user_index_path
		else
			render :action => 'edit'
		end
	end

	def destroy
		@user = Auth::Users.find(params[:id])
		if @user.destroy
			flash[:notice] = "Successfully deleted User."
			redirect_to admin_user_index_path
		end
	end

	def user_params
		params.require(:users).permit!
	end 
  end
end
