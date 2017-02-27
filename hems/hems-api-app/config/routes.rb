# == Route Map
#
#     Prefix Verb URI Pattern Controller#Action
#       home      /           Home::Engine
#       auth      /           Auth::Engine
#      admin      /           Admin::Engine
#      setup      /           Setup::Engine
#  reference      /           Reference::Engine
#      items      /           Items::Engine
# tax_charge      /           TaxCharge::Engine
#   facility      /           Facility::Engine
#      order      /           Order::Engine
#       bill      /           Bill::Engine
#
# Routes for Home::Engine:
#
#
# Routes for Auth::Engine:
#         new_user_session GET    /auth/users/sign_in(.:format)  devise/sessions#new
#             user_session POST   /auth/users/sign_in(.:format)  devise/sessions#create
#     destroy_user_session GET    /auth/users/sign_out(.:format) devise/sessions#destroy
# cancel_user_registration GET    /auth/users/cancel(.:format)   devise/registrations#cancel
#    new_user_registration GET    /auth/users/sign_up(.:format)  devise/registrations#new
#   edit_user_registration GET    /auth/users/edit(.:format)     devise/registrations#edit
#        user_registration PATCH  /auth/users(.:format)          devise/registrations#update
#                          PUT    /auth/users(.:format)          devise/registrations#update
#                          DELETE /auth/users(.:format)          devise/registrations#destroy
#                          POST   /auth/users(.:format)          devise/registrations#create
#
# Routes for Admin::Engine:
#   api_user_index GET    /api/user(.:format)     api/user#index {:_access=>"admin.user_mgmt.list_users"}
#  api_user_create POST   /api/user(.:format)     api/user#create {:_access=>"admin.user_mgmt.create_user"}
#    api_user_show GET    /api/user/:id(.:format) api/user#show {:_access=>"admin.user_mgmt.show_user"}
#  api_user_update PUT    /api/user/:id(.:format) api/user#update {:_access=>"admin.user_mgmt.update_user"}
# api_user_destroy DELETE /api/user/:id(.:format) api/user#destroy {:_access=>"admin.user_mgmt.delete_user"}
#
# Routes for Setup::Engine:
#
#
# Routes for Reference::Engine:
#   api_reference_types GET    /api/reference/types(.:format)            reference/api/ref_type#get_types {:format=>"json", :_access=>"setup.reference_mgmt.list_ref_types"}
#  api_reference_header GET    /api/reference/:ref_type/header(.:format) reference/api/ref_type#get_header {:format=>"json", :_access=>"setup.reference_mgmt.get_ref_header"}
#  api_reference_fields GET    /api/reference/:ref_type/fields(.:format) reference/api/ref_type#get_fields {:format=>"json", :_access=>"setup.reference_mgmt.get_ref_fields"}
#   api_reference_index GET    /api/reference/:ref_type(.:format)        reference/api/ref_code#index {:format=>"json", :_access=>"setup.reference_mgmt.list_ref_codes"}
#  api_reference_create POST   /api/reference/:ref_type(.:format)        reference/api/ref_code#create {:format=>"json", :_access=>"setup.reference_mgmt.create_ref_code"}
#    api_reference_show GET    /api/reference/:ref_type/:id(.:format)    reference/api/ref_code#show {:format=>"json", :_access=>"setup.reference_mgmt.show_ref_code"}
#  api_reference_update PUT    /api/reference/:ref_type/:id(.:format)    reference/api/ref_code#update {:format=>"json", :_access=>"setup.reference_mgmt.update_ref_code"}
# api_reference_destroy DELETE /api/reference/:ref_type/:id(.:format)    reference/api/ref_code#destroy {:format=>"json", :_access=>"setup.reference_mgmt.delete_ref_code"}
#
# Routes for Items::Engine:
#   api_items_sales_index GET    /api/items/sales(.:format)     items/api/sale_item#index {:format=>"json", :_access=>"setup.sale_items_mgmt.list_sale_items"}
#  api_items_sales_create POST   /api/items/sales(.:format)     items/api/sale_item#create {:format=>"json", :_access=>"setup.sale_items_mgmt.create_sale_item"}
#    api_items_sales_show GET    /api/items/sales/:id(.:format) items/api/sale_item#show {:format=>"json", :_access=>"setup.sale_items_mgmt.show_sale_item"}
#  api_items_sales_update PUT    /api/items/sales/:id(.:format) items/api/sale_item#update {:format=>"json", :_access=>"setup.sale_items_mgmt.update_sale_item"}
# api_items_sales_destroy DELETE /api/items/sales/:id(.:format) items/api/sale_item#destroy {:format=>"json", :_access=>"setup.sale_items_mgmt.delete_sale_item"}
#         api_items_index POST   /api/items/sale_list(.:format) items/api/sale_list#index {:format=>"json", :_access=>"order.order_mgmt.take_order"}
#
# Routes for TaxCharge::Engine:
#        api_taxcharge_code_index GET    /api/taxcharge/code(.:format)          tax_charge/api/tax_charge_code#index {:format=>"json", :_access=>"setup.taxcharge_code_mgmt.list_taxcharge_codes"}
#       api_taxcharge_code_create POST   /api/taxcharge/code(.:format)          tax_charge/api/tax_charge_code#create {:format=>"json", :_access=>"setup.taxcharge_code_mgmt.show_taxcharge_code"}
#         api_taxcharge_code_show GET    /api/taxcharge/code/:id(.:format)      tax_charge/api/tax_charge_code#show {:format=>"json", :_access=>"setup.taxcharge_code_mgmt.create_taxcharge_code"}
#       api_taxcharge_code_update PUT    /api/taxcharge/code/:id(.:format)      tax_charge/api/tax_charge_code#update {:format=>"json", :_access=>"setup.taxcharge_code_mgmt.update_taxcharge_code"}
#      api_taxcharge_code_destroy DELETE /api/taxcharge/code/:id(.:format)      tax_charge/api/tax_charge_code#destroy {:format=>"json", :_access=>"setup.taxcharge_code_mgmt.delete_taxcharge_code"}
#   api_taxcharge_component_index GET    /api/taxcharge/component(.:format)     tax_charge/api/tax_charge_comp#index {:format=>"json", :_access=>"setup.taxcharge_component_mgmt.list_taxcharge_components"}
#  api_taxcharge_component_create POST   /api/taxcharge/component(.:format)     tax_charge/api/tax_charge_comp#create {:format=>"json", :_access=>"setup.taxcharge_component_mgmt.create_taxcharge_component"}
#    api_taxcharge_component_show GET    /api/taxcharge/component/:id(.:format) tax_charge/api/tax_charge_comp#show {:format=>"json", :_access=>"setup.taxcharge_component_mgmt.show_taxcharge_component"}
#  api_taxcharge_component_update PUT    /api/taxcharge/component/:id(.:format) tax_charge/api/tax_charge_comp#update {:format=>"json", :_access=>"setup.taxcharge_component_mgmt.update_taxcharge_component"}
# api_taxcharge_component_destroy DELETE /api/taxcharge/component/:id(.:format) tax_charge/api/tax_charge_comp#destroy {:format=>"json", :_access=>"setup.taxcharge_component_mgmt.delete_taxcharge_component"}
#
# Routes for Facility::Engine:
#            api_facility_index GET    /api/facility(.:format)              facility/api/facility_master#index {:format=>"json", :_access=>"setup.facility_master_mgmt.list_facilities"}
#           api_facility_create POST   /api/facility(.:format)              facility/api/facility_master#create {:format=>"json", :_access=>"setup.facility_master_mgmt.create_facility"}
#             api_facility_show GET    /api/facility/:id(.:format)          facility/api/facility_master#show {:format=>"json", :_access=>"setup.facility_master_mgmt.show_facility"}
#           api_facility_update PUT    /api/facility/:id(.:format)          facility/api/facility_master#update {:format=>"json", :_access=>"setup.facility_master_mgmt.update_facility"}
#          api_facility_destroy DELETE /api/facility/:id(.:format)          facility/api/facility_master#destroy {:format=>"json", :_access=>"setup.facility_master_mgmt.delete_facility"}
#       api_facility_item_index GET    /api/facility_item(.:format)         facility/api/facility_item#index {:format=>"json", :_access=>"setup.facility_item_mgmt.list_facility_items"}
#      api_facility_item_create POST   /api/facility_item(.:format)         facility/api/facility_item#create {:format=>"json", :_access=>"setup.facility_item_mgmt.create_facility_item"}
#        api_facility_item_show GET    /api/facility_item/:id(.:format)     facility/api/facility_item#show {:format=>"json", :_access=>"setup.facility_item_mgmt.show_facility_item"}
#      api_facility_item_update PUT    /api/facility_item/:id(.:format)     facility/api/facility_item#update {:format=>"json", :_access=>"setup.facility_item_mgmt.update_facility_item"}
#     api_facility_item_destroy DELETE /api/facility_item/:id(.:format)     facility/api/facility_item#destroy {:format=>"json", :_access=>"setup.facility_item_mgmt.delete_facility_item"}
#   api_facility_tax_code_index GET    /api/facility_tax_code(.:format)     facility/api/facility_tax_code#index {:format=>"json", :_access=>"setup.facility_taxcode_mgmt.list_facility_taxcodes"}
#  api_facility_tax_code_create POST   /api/facility_tax_code(.:format)     facility/api/facility_tax_code#create {:format=>"json", :_access=>"setup.facility_taxcode_mgmt.create_facility_taxcode"}
#    api_facility_tax_code_show GET    /api/facility_tax_code/:id(.:format) facility/api/facility_tax_code#show {:format=>"json", :_access=>"setup.facility_taxcode_mgmt.show_facility_taxcode"}
#  api_facility_tax_code_update PUT    /api/facility_tax_code/:id(.:format) facility/api/facility_tax_code#update {:format=>"json", :_access=>"setup.facility_taxcode_mgmt.update_facility_taxcode"}
# api_facility_tax_code_destroy DELETE /api/facility_tax_code/:id(.:format) facility/api/facility_tax_code#destroy {:format=>"json", :_access=>"setup.facility_taxcode_mgmt.delete_facility_taxcode"}
#
# Routes for Order::Engine:
# api_manageorder_save POST /api/manageorder/save(.:format) order/api/manage_order#save {:format=>"json", :_access=>"order.order_mgmt.take_order"}
#
# Routes for Bill::Engine:
# api_managebill_prepare POST /api/managebill/prepare(.:format) bill/api/manage_bill#prepare {:format=>"json", :_access=>"bill.bill_mgmt.prepare_bill"}
#  api_managebill_update POST /api/managebill/update(.:format)  bill/api/manage_bill#update {:format=>"json", :_access=>"bill.bill_mgmt.update_bill"}
#

Rails.application.routes.draw do
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
