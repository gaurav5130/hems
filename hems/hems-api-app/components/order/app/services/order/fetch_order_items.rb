module Order
	class FetchOrderItems < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations

		attribute :facility_code, String
		attribute :member_id, String

		validates :facility_code, presence: true
		validates :member_id, presence: true

		private
		
		#Static and business validations of this service
		def validate
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new		
		end
		
		#Process logic of this service
		def process()
			item_gross=0
			orderhdr = OrderHeader.where(member_id: member_id).first
			order_item_list= OrderDetail.select("sum(facility_item_mapping.published_rate*order_detail.quantity) as price,
						sum(quantity) as quantity,sales_item_detail.short_name as item, sales_item_detail.item_code as code, 
						sales_item_detail.tax_category_code as item_category, facility_item_mapping.published_rate as published_rate")
				.joins("INNER JOIN order_header ON order_detail.order_number=order_header.order_number")
				.joins("INNER JOIN facility_item_mapping ON facility_item_mapping.item_code = order_detail.item_code")
				.joins("INNER JOIN sales_item_detail ON facility_item_mapping.item_code = sales_item_detail.item_code")
				.where("order_header.facility_code = facility_item_mapping.facility_code AND order_header.facility_code = ? AND order_header.member_id=? AND order_detail.corporate_id=? AND order_detail.establishment_id=?", facility_code, member_id,@context.corporate_id, @context.establishment_id)
				.group("sales_item_detail.item_code")
				.group("sales_item_detail.short_name")
				.group("sales_item_detail.tax_category_code")
				.group("facility_item_mapping.published_rate")

			result_list = []
			order_item_list.each do |one_rec|
				#TODO - To arrive at Unit Price; currently sending as Zero.
				obj = OrderItemVO.new(code:one_rec.code, title: one_rec.item, quantity: one_rec.quantity, 
						price: one_rec.price, category: one_rec.item_category, published_rate: one_rec.published_rate)
				result_list << obj

				item_gross+=one_rec.price
			end
			pp "Order Items -----------------"
			pp result_list
			pp item_gross
			pp orderhdr
			return result_list,item_gross,orderhdr
		end
	end
end