module Bill
	class PrepareBillResult
		include Virtus.model
		attribute :charges, TaxCharge::ChargeTaxSummaryVO
		attribute :taxes, TaxCharge::TaxSummaryVO
		attribute :items, Array[Order::OrderItemVO]
	end
end