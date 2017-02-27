require_dependency "core/application_controller"

module Reference
  class API::RefCodeController < Core::ApplicationController
	def index
		responder FetchRefCodeList.call(@context, params[:ref_type])
	end

	def create
		responder CreateRefCode.call(@context, params[:ref_type], code_params)
	end

	def show
		responder FetchRefCode.call(@context , params[:id], params[:ref_type])
	end

	def update
		responder UpdateRefCode.call(@context, params[:ref_type] , params[:id] ,code_params)
	end

	private

	def code_params
		field_list_obj = FetchRefFieldList.call(@context, params[:ref_type])
		field_list = field_list_obj.data?
		additional_field =[]
		field_list.each do |field|
			if field["is_additional"] == true
				additional_field.push(field["fld_name"])
			end
		end
		params.require(:codes).permit(:code,:desc,:alt_desc,:short_desc,additional_data: additional_field)
	end
  end
end
