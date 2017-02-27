TaxCharge::Engine.routes.draw do
	namespace :api , defaults: {format: 'json'} do
		namespace :taxcharge do		
			namespace :code do
				get "/" 		=> "/tax_charge/api/tax_charge_code#index", _access: "setup.taxcharge_code_mgmt.list_taxcharge_codes", as: "index"
				post "/" 		=> "/tax_charge/api/tax_charge_code#create", _access: "setup.taxcharge_code_mgmt.show_taxcharge_code", as: "create"
				get "/:id"		=> "/tax_charge/api/tax_charge_code#show", _access: "setup.taxcharge_code_mgmt.create_taxcharge_code", as: "show"
				put "/:id"		=> "/tax_charge/api/tax_charge_code#update", _access: "setup.taxcharge_code_mgmt.update_taxcharge_code", as: "update"
				delete "/:id"	=> "/tax_charge/api/tax_charge_code#destroy", _access: "setup.taxcharge_code_mgmt.delete_taxcharge_code", as: "destroy"
			end
			namespace :component do
				get "/" 		=> "/tax_charge/api/tax_charge_comp#index", _access: "setup.taxcharge_component_mgmt.list_taxcharge_components", as: "index"
				post "/" 		=> "/tax_charge/api/tax_charge_comp#create", _access: "setup.taxcharge_component_mgmt.create_taxcharge_component", as: "create"
				get "/:id"		=> "/tax_charge/api/tax_charge_comp#show", _access: "setup.taxcharge_component_mgmt.show_taxcharge_component", as: "show"
				put "/:id"		=> "/tax_charge/api/tax_charge_comp#update", _access: "setup.taxcharge_component_mgmt.update_taxcharge_component", as: "update"
				delete "/:id"	=> "/tax_charge/api/tax_charge_comp#destroy", _access: "setup.taxcharge_component_mgmt.delete_taxcharge_component", as: "destroy"
			end
		end
	end
end
