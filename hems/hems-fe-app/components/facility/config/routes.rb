Facility::Engine.routes.draw do
	namespace :facility do
		get "/" => "/facility/facility_master_web#index", as: "index"
	end
	namespace :facility_item do
		get "/" => "/facility/facility_item_web#index", as: "index"
	end
	namespace :facility_tax_code do
		get "/" => "/facility/facility_tax_code_web#index", as: "index"
	end
end
