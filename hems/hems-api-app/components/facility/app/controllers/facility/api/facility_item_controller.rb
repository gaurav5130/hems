require_dependency "core/application_controller"

module Facility
  class API::FacilityItemController < Core::ApplicationController
	def index
		responder RetrieveFacilityItems.call(@context, params)
	end

	def create
		responder CreateFacilityItem.call(@context,params)
	end

	def show
		responder FetchFacilityItem.call(@context, params)
	end

	def update
		responder UpdateFacilityItem.call(@context,params)
	end
  end
end
