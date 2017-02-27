Bill::Engine.routes.draw do
	namespace :bill do
		get "/prepare" => "/bill/bill_web#prepare", _access: "bill.bill_mgmt.prepare_bill"
		get "/update" => "/bill/bill_web#update"
	end
end
