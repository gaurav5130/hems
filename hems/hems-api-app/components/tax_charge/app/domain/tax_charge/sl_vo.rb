module TaxCharge
	class SlVO
		include ActiveModel::Validations
		include Virtus.model

		attribute :serial_no, Integer
		attribute :slab_start_amount, Float
		attribute :slab_end_amount, Float
		attribute :slab_applicable_amount, Float
		attribute :slab_calculation_type, String

		validates :serial_no, presence: true
		validates :slab_start_amount, presence: true
		validates :slab_end_amount, presence: true
		validates :slab_applicable_amount, presence: true
		validates :slab_calculation_type, presence: true
	end
end