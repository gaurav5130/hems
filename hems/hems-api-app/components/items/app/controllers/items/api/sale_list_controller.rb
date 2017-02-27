require_dependency "core/application_controller"

module Items
  class API::SaleListController < Core::ApplicationController
	def index
		 responder RetrieveAllSaleItems.call(@context, facility_code: params[:facility_code])
	end  
  end
end
