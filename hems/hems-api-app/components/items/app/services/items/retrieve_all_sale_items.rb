module Items
	class RetrieveAllSaleItems	< Core::BaseService
		include Virtus.model
		include ActiveModel::Validations

		attribute :facility_code, String
		validates :facility_code, presence: true
		
		private
		def validate	
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new		
		end

		#Process logic of this service
		def process()
			# data= SalesItemDetail.select("sales_item_detail.item_code as itemcode,sales_item_detail.short_name as itemname,facility_item_mapping.published_rate as price,itemdetail.unit as unit").joins("INNER JOIN facility_item_mapping ON facility_item_mapping.item_code = sales_item_detail.item_code").joins("INNER JOIN itemdetail ON itemdetail.itemcode=sales_item_detail.item_code").where("sales_item_detail.corporate_id=? AND sales_item_detail.establishment_id=?",@context.corporate_id, @context.establishment_id)

			data= SalesItemDetail.select("sales_item_detail.item_code as itemcode,sales_item_detail.short_name as itemname,facility_item_mapping.published_rate as price").joins("INNER JOIN facility_item_mapping ON facility_item_mapping.item_code = sales_item_detail.item_code").where("facility_item_mapping.facility_code=? and sales_item_detail.corporate_id=? AND sales_item_detail.establishment_id=?",@facility_code, @context.corporate_id, @context.establishment_id)
			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data(data)
			success_obj
		end
	end
end