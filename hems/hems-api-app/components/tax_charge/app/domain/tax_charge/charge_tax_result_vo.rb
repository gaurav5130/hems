module TaxCharge
	class ChargeTaxResultVO
		include ActiveModel::Validations
		include Virtus.model
		
		attribute :charges, ChargeTaxSummaryVO
		attribute :taxes, 	TaxSummaryVO

		def initialize()
			@charges = ChargeTaxSummaryVO.new
			@taxes = TaxSummaryVO.new

			@charges.tot_amt = 0
			@taxes.tot_amt = 0
			@taxes.comp_hash = Hash.new
		end
	end
end