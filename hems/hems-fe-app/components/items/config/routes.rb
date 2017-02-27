Items::Engine.routes.draw do
	namespace :items do
		get "/" => "/items/item_web#index", as: "index"
	end
end
