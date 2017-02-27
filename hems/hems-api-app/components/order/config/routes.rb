Order::Engine.routes.draw do
	namespace :api , defaults: {format: 'json'} do
		namespace :manageorder do
			post "/save" 		=> "/order/api/manage_order#save", _access:"order.order_mgmt.take_order", as: "save"
		end
	end
end
