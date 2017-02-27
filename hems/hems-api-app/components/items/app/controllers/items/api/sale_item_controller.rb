require_dependency "core/application_controller"

module Items
  class API::SaleItemController < Core::ApplicationController

	def create
		responder CreateSalesItem.call(@context, params)
	end

	def show
		responder FetchSalesItem.call(@context, params)
	end
	
	def update
		responder UpdateSalesItem.call(@context, params)
	end
	
	def index
		responder RetrieveSalesItems.call(@context, params)
	end

	def destroy
		#TODO
	end
  end
end
