module Items
	class UpdateSalesItem	< Core::BaseService
		include Virtus.model
		include ActiveModel::Validations
		attribute :item_code, String
		attribute :short_name, String
		attribute :long_name, String
		attribute :item_type, String
		attribute :tax_category_code, String
		attribute :id, String

		validates :tax_category_code, presence: true
		validates :id, presence: true
		validates :item_code, presence: true
		validates :item_type, presence: true

		#Initialization of this service
		def initialize(params)
			@id=params[:id]
	      	@item_code=params[:item_code]
		  	@short_name=params[:short_name]
			@long_name=params[:long_name]
			@item_type=params[:item_type]
			@tax_category_code=params[:tax_category_code]
		end
		def validate
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new		
		end
		def process
			sale_item_detail=SalesItemDetail.where(id: @id, corporate_id: @context.corporate_id, establishment_id: @context.establishment_id).first
			sale_item_detail.item_code=@item_code
			sale_item_detail.item_type=@item_type
			sale_item_detail.short_name=@short_name
			sale_item_detail.long_name=@long_name
			sale_item_detail.tax_category_code=@tax_category_code

			sale_item_detail.updated_at=DateTime.now
			sale_item_detail.save!

			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data({"msg": "Code Updated"})
			success_obj
		end
	end
end