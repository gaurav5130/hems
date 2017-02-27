require_dependency "core/application_controller"

module Bill
	class API::ManageBillController < Core::ApplicationController
		
		def prepare
			responder PrepareBill.call(@context, params)
		end

		def update
			responder UpdateBill.call(@context, bill_number: params[:bill_number], items_discount: params[:itemsDiscount],
				bill_discount: params[:billDiscount])
		end

		def delete
			responder DeleteBill.call(@context, bill_number: params[:bill_number])
		end
	end
end
