Home::Engine.routes.draw do
	root to: '/home/home#index', _access: '_skip'

	namespace :home do
		get "/denied"  	=> "/home/home#denied", 	_access: "_skip",	as: "denied"
	end

	namespace :api , defaults: {format: 'json'} do
		namespace :home do
			post "access" => "/home/api/home#user_access_info", _access: '_skip'
		end
	end
end


