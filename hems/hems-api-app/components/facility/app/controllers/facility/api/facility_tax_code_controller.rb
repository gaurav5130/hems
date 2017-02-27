require_dependency "core/application_controller"

module Facility
  class API::FacilityTaxCodeController < Core::ApplicationController
	def index
		responder RetrieveFacilityTaxCodes.call(@context, params)
	end

	def create
		responder CreateFacilityTaxCode.call(@context,params)
	end
	
	def show
		responder FetchFacilityTaxCode.call(@context, params)
	end

	def update
		responder UpdateFacilityTaxCode.call(@context,params)
	end
  end
end
