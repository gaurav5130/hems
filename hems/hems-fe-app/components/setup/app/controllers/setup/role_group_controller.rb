require_dependency "core/web_controller"

module Setup
  class RoleGroupController < Core::WebController
	def index
		@roles = Auth::RoleGroup.apply_context(context)
	end

	def new
		@role = Auth::RoleGroup.new
	end

	def create
		@role = Auth::RoleGroup.new(role_params)
		if @role.save
			flash[:notice] = "Successfully created Role Group." 
			redirect_to setup_rolegroup_index_path
		else
			render :action => 'new'
		end
	end

	def show
		@role = Auth::RoleGroup.find(params[:id])
	end

	def edit
		@role = Auth::RoleGroup.find(params[:id])
	end

	def update
		@role = Auth::RoleGroup.find(params[:id])
		if @role.update_attributes(role_params)
			flash[:notice] = "Successfully updated Role Group."
			redirect_to setup_rolegroup_index_path
		else
			render :action => 'edit'
		end
	end

	def destroy
		@role = Auth::RoleGroup.find(params[:id])
		if @role.destroy
			flash[:notice] = "Successfully deleted Role Group."
			redirect_to setup_rolegroup_index_path
		end
	end

	def role_params
		params.require(:role_group).permit(:corporate_id, :establishment_id, :code, :desc, {:user_roles => []})
	end 
  end
end