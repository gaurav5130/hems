module TaxCharge
	class ChargeTaxComponentVO
	    include ActiveModel::Validations
	    include Virtus.model

		attribute :comp_id, String
		attribute :title, String
		attribute :type, String
		attribute :calc_amt, Float
		attribute :rounded_amt, Float
		attribute :serial_no, Integer

		validates :comp_id, presence: true
		validates :title, presence: true
		validates :type, presence: true
		validates :calc_amt, presence: true
		validates :rounded_amt, presence: true
	end
end