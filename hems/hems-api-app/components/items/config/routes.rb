Items::Engine.routes.draw do
	namespace :api , defaults: {format: 'json'} do
		namespace :items do
			namespace :sales do
				get "/" 		=> "/items/api/sale_item#index", _access: "setup.sale_items_mgmt.list_sale_items", as: "index"
				post "/" 		=> "/items/api/sale_item#create", _access: "setup.sale_items_mgmt.create_sale_item", as: "create"
				get "/:id"		=> "/items/api/sale_item#show", _access: "setup.sale_items_mgmt.show_sale_item", as: "show"
				put "/:id"		=> "/items/api/sale_item#update", _access: "setup.sale_items_mgmt.update_sale_item", as: "update"
				delete "/:id"	=> "/items/api/sale_item#destroy", _access: "setup.sale_items_mgmt.delete_sale_item", as: "destroy"
			end

			post "sale_list" 	=> "/items/api/sale_list#index", _access: "order.order_mgmt.take_order", as: "index"
		end
	end
end
