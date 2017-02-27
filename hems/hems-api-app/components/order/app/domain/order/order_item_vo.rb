module Order
	class OrderItemVO
		include ActiveModel::Validations
		include Virtus.model

		attribute :code, String
		attribute :title, String
		attribute :quantity, String
		attribute :published_rate, Float
		attribute :discount, Float , :default => 0
		attribute :price, Float
		attribute :category, String

		validates :code, presence: true
		validates :title, presence: true
		validates :quantity, presence: true
		validates :price, presence: true

	end
end
