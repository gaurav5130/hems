module Order
	class OrderItemCategoryVO
		include ActiveModel::Validations
		include Virtus.model

		attribute :facility_id, String
		attribute :item_category, String
		attribute :category_total, Float
		attribute :tax_code, String

		validates :facility_id, presence: true
		validates :item_category, presence: true
		validates :category_total, presence: true
		validates :tax_code, presence: true
	end
end