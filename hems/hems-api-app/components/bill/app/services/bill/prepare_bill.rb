module Bill
	class PrepareBill	< Core::BaseService
		include Virtus.model
		include ActiveModel::Validations
		attribute :member_id, String
		attribute :facility_id, String

		validates :member_id, presence: true
		validates :facility_id, presence: true

		#Initialization of this service
		def initialize(params)
			@member_id=params[:member_id]
			@facility_id=params[:facility_code]
		end
		
		private
		
		#Static and business validations of this service
		def validate	
			if !(valid?)
				return Core::ServiceError.new("Mandatory fields not available")
			end
			return Core::ServiceSuccess.new	
		end
		
		#Process logic of this service
		def process
			order_category_list = Order::FetchOrderItemsByCategory.call(@context, member_id: @member_id, facility_id: @facility_id)
			order_item_list,item_gross, orderhdr = Order::FetchOrderItems.call(@context, member_id: @member_id, facility_code: @facility_id)
			
			chargetax_result = TaxCharge::ComputeChargeTax.call(@context, facility_id: @facility_id, order_category_list: order_category_list)
			
			pp "Prepare Bill Details --------------"
			pp chargetax_result

			bill_result_vo = PrepareBillResult.new
			bill_result_vo.charges = chargetax_result.charges
			bill_result_vo.taxes = chargetax_result.taxes
			bill_result_vo.items = order_item_list

			pp order_item_list

			CreateBill.call(@context, facility_code: facility_id, bill_result: bill_result_vo, gross_total: item_gross, order: orderhdr)
		end
	end
end
