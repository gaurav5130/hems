TaxCharge::Engine.routes.draw do
	namespace :taxcharge do
		namespace :code do
			get "/" => "/tax_charge/tax_charge_code_web#index"
		end
		namespace :component do
			get "/" => "/tax_charge/tax_charge_component_web#index"
		end
	end	
end
