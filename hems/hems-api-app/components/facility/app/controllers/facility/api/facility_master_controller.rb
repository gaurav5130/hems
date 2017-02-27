require_dependency "core/application_controller"

module Facility
  class API::FacilityMasterController < Core::ApplicationController
	def index
		responder RetrieveFacilityMaster.call(@context, params)
	end

	def create
		responder CreateFacilityMaster.call(@context,params)
	end

	def show
		responder FetchFacilityMaster.call(@context, params)
	end

	def update
		responder UpdateFacilityMaster.call(@context,params)
	end
  end
end
