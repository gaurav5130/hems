module TaxCharge
	class TaxSummaryVO
		include ActiveModel::Validations
		include Virtus.model
		
		attribute :tot_amt,		Float
		attribute :comp_hash, 	Hash[String => Array[ChargeTaxSummaryVO]]
	end
end

# { String => Array[ChargeTaxComponentVO]}