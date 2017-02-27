Reference::Engine.routes.draw do
	namespace :reference do
		get "/" => "/reference/ref_web#index", _access: "setup.reference_mgmt.list_types", as: "index"
	end
end
