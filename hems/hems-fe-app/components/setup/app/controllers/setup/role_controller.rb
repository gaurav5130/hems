require_dependency "core/web_controller"

module Setup
  class RoleController < Core::WebController
	def index
		@roles = Auth::Role.apply_context(context)
	end

	def new
		@role = Auth::Role.new
	end

	def create
		@role = Auth::Role.new(role_params)
		if @role.save
			flash[:notice] = "Successfully created Role." 
			redirect_to setup_role_index_path
		else
			render :action => 'new'
		end
	end

	def show
		@role = Auth::Role.find(params[:id])
	end

	def edit
		@role = Auth::Role.find(params[:id])
	end

	def update
		@role = Auth::Role.find(params[:id])
		if @role.update_attributes(role_params)
			flash[:notice] = "Successfully updated Role."
			redirect_to setup_role_index_path
		else
			render :action => 'edit'
		end
	end

	def destroy
		@role = Auth::Role.find(params[:id])
		if @role.destroy
			flash[:notice] = "Successfully deleted Role."
			redirect_to setup_role_index_path
		end
	end

	def role_params
		params.require(:role).permit!
	end 
  end
end