module TaxCharge
	class ChargeTaxSummaryVO
		include ActiveModel::Validations
		include Virtus.model
		
		attribute :tot_amt,		Float
		attribute :comp_list, 	Array[ChargeTaxComponentVO]
	end
end