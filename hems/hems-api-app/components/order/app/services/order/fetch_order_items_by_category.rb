module Order
	class FetchOrderItemsByCategory < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations

		attribute :facility_id, String
		attribute :member_id, String

		validates :facility_id, presence: true
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
			# order_list= OrderDetail.select("sum(facility_item_mapping.published_rate*order_detail.quantity) as category_total,sum(quantity) as quant,sales_item_detail.tax_category_code as code").joins("INNER JOIN order_header ON order_detail.order_number=order_header.order_number").joins("INNER JOIN facility_item_mapping ON facility_item_mapping.item_code = order_detail.item_code").joins("INNER JOIN sales_item_detail ON order_detail.item_code = sales_item_detail.item_code").where("order_detail.order_number=order_header.order_number AND order_header.member_id=? AND order_detail.corporate_id=? AND order_detail.establishment_id=?",member_id,@context.corporate_id, @context.establishment_id).group("sales_item_detail.tax_category_code")
				
			# order_list= OrderDetail.select("SELECT sum(e_schema.facility_item_mapping.published_rate * e_schema.order_detail.quantity) as category_total," \
			# 		"sum(e_schema.order_detail.quantity) as quant," \
			# 		"e_schema.sales_item_detail.tax_category_code as code" \
			# 		"FROM e_schema.order_detail " \
			# 		"INNER JOIN e_schema.order_header ON e_schema.order_detail.order_number = e_schema.order_header.order_number " \
			# 		"INNER JOIN e_schema.facility_item_mapping ON e_schema.facility_item_mapping.item_code = e_schema.order_detail.item_code " \
			# 		"INNER JOIN e_schema.sales_item_detail ON e_schema.sales_item_detail.item_code = e_schema.order_detail.item_code " \
			# 		"WHERE (e_schema.facility_item_mapping.facility_code = e_schema.order_header.facility_code " \
			# 				"and e_schema.order_header.facility_code = 'FAC001' AND e_schema.order_header.member_id = '111' " \
			# 		       "AND e_schema.order_detail.corporate_id='C1' AND e_schema.order_detail.establishment_id='E1') " \
			# 		"GROUP BY e_schema.sales_item_detail.tax_category_code")

			order_list= OrderDetail.select("sum(facility_item_mapping.published_rate*order_detail.quantity) as category_total,sum(quantity) as quant,sales_item_detail.tax_category_code as code")
				.joins("INNER JOIN order_header ON order_detail.order_number=order_header.order_number")
				.joins("INNER JOIN facility_item_mapping ON facility_item_mapping.item_code = order_detail.item_code")
				.joins("INNER JOIN sales_item_detail ON order_detail.item_code = sales_item_detail.item_code")
				.where("facility_item_mapping.facility_code = order_header.facility_code AND order_header.facility_code = ? AND order_header.member_id=? AND order_detail.corporate_id=? AND order_detail.establishment_id=?", facility_id, member_id,@context.corporate_id, @context.establishment_id)
				.group("sales_item_detail.tax_category_code")

			p "before checking list"
			order_category_list = []
			order_list.each do |one_rec|
			p one_rec.code
				tax = Facility::FacilityTaxCodeMapping.where(item_tax_category_code: one_rec.code).first
				obj = OrderItemCategoryVO.new(facility_id: facility_id, item_category: one_rec.code, 
						category_total: one_rec.category_total, tax_code: tax.tax_code)
				order_category_list << obj
			end		
			p "the order list"
			p order_category_list
			order_category_list
		end
	end
end