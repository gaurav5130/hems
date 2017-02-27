Setup::Engine.routes.draw do
	namespace :setup do
		get "/" => "/setup/setup#index",	_access: "setup", 	as: "index"

		namespace :role do
			get "/" 		=> "/setup/role#index",		_access: "setup.role_mgmt.list_roles",	as: "index"
			get "/new" 		=> "/setup/role#new", 		_access: "setup.role_mgmt.create_role",	as: "new"
			post "/" 		=> "/setup/role#create",	_access: "setup.role_mgmt.create_role",	as: "create"
			get "/:id"		=> "/setup/role#show",		_access: "setup.role_mgmt.show_role",		as: "show"
			get "/:id/edit" => "/setup/role#edit",		_access: "setup.role_mgmt.update_role",	as: "edit"
			put "/:id"		=> "/setup/role#update",	_access: "setup.role_mgmt.update_role",	as: "update"
			delete "/:id"	=> "/setup/role#destroy",	_access: "setup.role_mgmt.delete_role",	as: "destroy"
		end

		namespace :rolegroup do
			get "/" 		=> "/setup/role_group#index",	_access: "setup.role_group_mgmt.list_role_groups",	as: "index"
			get "/new" 		=> "/setup/role_group#new", 	_access: "setup.role_group_mgmt.create_role_group",	as: "new"
			post "/" 		=> "/setup/role_group#create",	_access: "setup.role_group_mgmt.create_role_group",	as: "create"
			get "/:id"		=> "/setup/role_group#show",	_access: "setup.role_group_mgmt.show_role_group",		as: "show"
			get "/:id/edit" => "/setup/role_group#edit",	_access: "setup.role_group_mgmt.update_role_group",	as: "edit"
			put "/:id"		=> "/setup/role_group#update",	_access: "setup.role_group_mgmt.update_role_group",	as: "update"
			delete "/:id"	=> "/setup/role_group#destroy",	_access: "setup.role_group_mgmt.delete_role_group",	as: "destroy"
		end

		namespace :roleaccess do
			get "/"			=> "/setup/role_access#index",	_access: "setup.role_access_mgmt.set_role_access", as: "index"
		end
	end
end