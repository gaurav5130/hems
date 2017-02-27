require_dependency "core/application_controller"

module Order
  class API::ManageOrderController < Core::ApplicationController
  	def save
		params.permit(:member_id,:facility_code,:table_number,:waitor,:steward,:item_name,:quantity)
		#params.permit!
		responder SaveOrder.call(@context,params)
  	end
  end
end
