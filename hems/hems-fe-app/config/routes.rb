Rails.application.routes.draw do
	as :user do
   		get	'/auth/users',		:to => 'devise/registrations#edit', 	  :as => :user_root
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	mount Home::Engine => "/", as: "/home"
	mount Auth::Engine => "/", as: "/auth"
	mount Admin::Engine => "/", as: "/admin"
	mount Setup::Engine => "/", as: "/setup"
	mount Reference::Engine => "/", as: "/reference"
	mount Items::Engine => "/", as: "/items"
	mount TaxCharge::Engine => "/", as: "/tax_charge"
	mount Facility::Engine => "/", as: "/facility"
	mount Order::Engine => "/", as: "/order"
	mount Bill::Engine => "/", as: "/bill"
end
