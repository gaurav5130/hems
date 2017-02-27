require_dependency "core/application_controller"

module Reference
  class API::RefTypeController < Core::ApplicationController
	def get_types
		responder FetchRefTypeList.call(@context)
	end

	def get_header
		responder FetchRefHeader.call(@context, params[:ref_type])
	end

	def get_fields
		responder FetchRefFieldList.call(@context, params[:ref_type])
	end
  end
end
