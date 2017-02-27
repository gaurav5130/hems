require_dependency "core/application_controller"

module TaxCharge
  class API::TaxChargeCompController < Core::ApplicationController

	def index
		responder RetrieveTaxChargeComponents.call(@context, params)
	end

	def create
		responder CreateTaxChargeComponent.call(@context,params)
	end

	def show
		responder FetchTaxChargeComponent.call(@context, params)
	end
	
	def update
		responder UpdateTaxChargeComponent.call(@context, params)
	end

	def destroy
		responder DeleteTaxChargeComponent.call(@context, params)
	end
  end
end
