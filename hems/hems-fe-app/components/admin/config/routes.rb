Admin::Engine.routes.draw do
	namespace :admin do
		get "/" => "/admin/admin#index",	_access: "admin", 	as: "index"

		#resources :user, path: "/admin/user" #Move this line out of admin namespace.
		namespace :user do
			get "/" 		=> "/admin/user#index",	_access: "admin.user_mgmt.list_users",	as: "index"
			get "/new" 		=> "/admin/user#new", 	_access: "admin.user_mgmt.create_user",	as: "new"
			post "/" 		=> "/admin/user#create",_access: "admin.user_mgmt.create_user",	as: "create"
			get "/:id"		=> "/admin/user#show",	_access: "admin.user_mgmt.show_user",		as: "show"
			get "/:id/edit" => "/admin/user#edit",	_access: "admin.user_mgmt.update_user",	as: "edit"
			put "/:id"		=> "/admin/user#update",_access: "admin.user_mgmt.update_user",	as: "update"
			delete "/:id"	=> "/admin/user#destroy",_access: "admin.user_mgmt.delete_user",	as: "destroy"
		end
	end
end