Admin::Engine.routes.draw do
	namespace :api do
		# resources :user, path: "/admin/user" #Move this line out of admin namespace.
		namespace :user do
			get "/" 		=> "/api/user#index",	_access: "admin.user_mgmt.list_users",	as: "index"
			post "/" 		=> "/api/user#create",_access: "admin.user_mgmt.create_user",	as: "create"
			get "/:id"		=> "/api/user#show",	_access: "admin.user_mgmt.show_user",		as: "show"
			put "/:id"		=> "/api/user#update",_access: "admin.user_mgmt.update_user",	as: "update"
			delete "/:id"	=> "/api/user#destroy",_access: "admin.user_mgmt.delete_user",	as: "destroy"
		end
	end
end