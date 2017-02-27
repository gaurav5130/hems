Order::Engine.routes.draw do
	namespace :manageorder do
		get "/takeorder" => "/order/order_web#take_order", _access: "order.order_mgmt.take_order"
	end
end
