Facility::Engine.routes.draw do
	namespace :api , defaults: {format: 'json'} do
		namespace :facility do
			get "/" 		=> "/facility/api/facility_master#index", _access: "setup.facility_master_mgmt.list_facilities", as: "index"
			post "/" 		=> "/facility/api/facility_master#create", _access: "setup.facility_master_mgmt.create_facility", as: "create"
			get "/:id"		=> "/facility/api/facility_master#show", _access: "setup.facility_master_mgmt.show_facility", as: "show" 
			put "/:id"		=> "/facility/api/facility_master#update", _access: "setup.facility_master_mgmt.update_facility", as: "update"
			delete "/:id"	=> "/facility/api/facility_master#destroy", _access: "setup.facility_master_mgmt.delete_facility", as: "destroy"
		end
		namespace :facility_item do
			get "/" 		=> "/facility/api/facility_item#index", _access: "setup.facility_item_mgmt.list_facility_items", as: "index"
			post "/" 		=> "/facility/api/facility_item#create", _access: "setup.facility_item_mgmt.create_facility_item", as: "create"
			get "/:id"		=> "/facility/api/facility_item#show", _access: "setup.facility_item_mgmt.show_facility_item", as: "show"
			put "/:id"		=> "/facility/api/facility_item#update", _access: "setup.facility_item_mgmt.update_facility_item", as: "update"
			delete "/:id"	=> "/facility/api/facility_item#destroy", _access: "setup.facility_item_mgmt.delete_facility_item", as: "destroy"
		end
		namespace :facility_tax_code do
			get "/" 		=> "/facility/api/facility_tax_code#index", _access: "setup.facility_taxcode_mgmt.list_facility_taxcodes", as: "index"
			post "/" 		=> "/facility/api/facility_tax_code#create", _access: "setup.facility_taxcode_mgmt.create_facility_taxcode", as: "create"
			get "/:id"		=> "/facility/api/facility_tax_code#show", _access: "setup.facility_taxcode_mgmt.show_facility_taxcode", as: "show"
			put "/:id"		=> "/facility/api/facility_tax_code#update", _access: "setup.facility_taxcode_mgmt.update_facility_taxcode", as: "update"
			delete "/:id"	=> "/facility/api/facility_tax_code#destroy", _access: "setup.facility_taxcode_mgmt.delete_facility_taxcode", as: "destroy"
		end
	end
end
