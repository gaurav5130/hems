Bill::Engine.routes.draw do
	namespace :api , defaults: {format: 'json'} do
		namespace :managebill do
			post "/prepare"		=> "/bill/api/manage_bill#prepare", _access: "bill.bill_mgmt.prepare_bill"
			post "/update"	=> "/bill/api/manage_bill#update", _access: "bill.bill_mgmt.update_bill"
			post "/delete"	=> "/bill/api/manage_bill#delete", _access: "bill.bill_mgmt.delete_bill"
		end
	end
end
