module TaxCharge
	class ChargeTaxInputVO
		include ActiveModel::Validations
		include Virtus.model
		
		attribute :code, String
		attribute :type, String #TODO - Validate as charge or tax
		attribute :charge_rate, Float
		attribute :rack_rate, Float

	    validates :code, presence: true
	    validates :type, presence: true
	    validates :charge_rate, presence: true
	    validates :rack_rate, presence: true
	end
end