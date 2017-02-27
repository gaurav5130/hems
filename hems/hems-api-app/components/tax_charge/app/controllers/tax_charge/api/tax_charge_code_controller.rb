require_dependency "core/application_controller"

module TaxCharge
  class API::TaxChargeCodeController < Core::ApplicationController

	def index
		responder RetrieveTaxChargeCodes.call(@context, params)		
	end

	def create
		responder CreateTaxChargeCode.call(@context,params)
	end

	def show
		responder FetchTaxChargeCode.call(@context, params)
	end	
	
	def update
		responder UpdateTaxChargeCode.call(@context,params)
	end

	def destroy
		responder DeleteTaxChargeCode.call(@context, params)
	end
  end
end
