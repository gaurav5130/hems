Reference::Engine.routes.draw do
	namespace :api , defaults: {format: 'json'} do
		namespace :reference do
			get "types" 			=> "/reference/api/ref_type#get_types",		_access: "setup.reference_mgmt.list_ref_types", as: "types"
			get ":ref_type/header" 	=> "/reference/api/ref_type#get_header",	_access: "setup.reference_mgmt.get_ref_header", as: "header"	
			get ":ref_type/fields" 	=> "/reference/api/ref_type#get_fields",	_access: "setup.reference_mgmt.get_ref_fields",	as: "fields"

			get ":ref_type/" 		=> "/reference/api/ref_code#index",		_access: "setup.reference_mgmt.list_ref_codes",		as: "index"
			post ":ref_type/" 		=> "/reference/api/ref_code#create",	_access: "setup.reference_mgmt.create_ref_code",	as: "create"
			get ":ref_type/:id"		=> "/reference/api/ref_code#show",		_access: "setup.reference_mgmt.show_ref_code",		as: "show"
			put ":ref_type/:id"		=> "/reference/api/ref_code#update",	_access: "setup.reference_mgmt.update_ref_code",	as: "update"
			delete ":ref_type/:id"	=> "/reference/api/ref_code#destroy",	_access: "setup.reference_mgmt.delete_ref_code",	as: "destroy"
		end
	end
end