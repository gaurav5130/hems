module TaxCharge
	class ComputeChargeTax < Core::BaseService
		class NoTaxCodeDefinedError < StandardError; end

		include Virtus.model
		include ActiveModel::Validations

		attribute :facility_id, String
		attribute :order_category_list, Array[Order::OrderItemCategoryVO]

		attribute :charge_code, 		String,							:writer => :private
		attribute :charge_tax_code, 	String,							:writer => :private
		attribute :all_tax_amt,			Float,							:writer => :private
		attribute :all_tax_comp_list, 	Array[ChargeTaxComponentVO],	:writer => :private
		attribute :result_vo,			ChargeTaxResultVO,				:writer => :private
		validates :facility_id, presence: true

		def validate()
			# if !(valid? && (order_category_list.size() > 0))
			# 	return ServiceError.new("Mandatory fields not available")
			# end
			return Core::ServiceSuccess.new
		end
		
		def process()
			@all_tax_amt = 0
			@all_tax_comp_list = []
			@result_vo = ChargeTaxResultVO.new

			compute_facility_charge_and_tax()

			compute_orderitem_taxes()

			# consolidate_taxes()

			return @result_vo
		end

		def compute_facility_charge_and_tax()
			#Compute charges and taxes for a facility
			compute_charges()
			if facility_charge_exists
				compute_tax(@charge_tax_code, @result_vo.charges.tot_amt, "charges")
			end
		end

		def compute_charges()
			@charge_code, @charge_tax_code = get_charge_tax_code()
			if facility_charge_exists
				unless @charge_tax_code
					raise NoTaxCodeDefinedError.new "Charge code is defined but no tax code defined"	
				end
				gross_total = get_gross_total()
				tot_amt, comp_list = compute("C", @charge_code, gross_total)
				@result_vo.charges = ChargeTaxSummaryVO.new(tot_amt: tot_amt, comp_list: comp_list)
			end
		end

		def compute_orderitem_taxes()
			order_category_list.each do |one_rec|
				compute_tax(one_rec.tax_code, one_rec.category_total, one_rec.item_category)
			end
		end

		def compute_tax(code, amt, item_category)
			tot_amt,comp_list = compute("T", code, amt)
			tax_comp = ChargeTaxSummaryVO.new(tot_amt: tot_amt, comp_list: comp_list)
			@result_vo.taxes.comp_hash[item_category] = tax_comp
			@result_vo.taxes.tot_amt = @result_vo.taxes.tot_amt.to_f + tot_amt.to_f
		end

		def compute(type, code, amt)
			vo = ChargeTaxInputVO.new(type: type, code: code, charge_rate: amt, rack_rate: amt)
			tot_amt,comp_list =  CalcChargeTax.call(@context, vo)
			return tot_amt,comp_list
		end

		# def consolidate_taxes()	
		# 	#Set Total Amount
		# 	@result_vo.taxes.tot_amt = @all_tax_amt

		# 	#Consolidate Tax Components
		# 	comp_hash = Hash.new
		# 	@all_tax_comp_list.each do |one_rec|
		# 		comp_id = one_rec.comp_id
		# 		if comp_hash.key?(comp_id)
		# 			comp_hash[comp_id].calc_amt += one_rec.calc_amt
		# 			comp_hash[comp_id].rounded_amt += one_rec.rounded_amt
		# 		else
		# 			comp_hash[comp_id] = one_rec
		# 		end
		# 	end

		# 	comp_hash.each {|key, value|
		# 		@result_vo.taxes.comp_list << value
		# 	}
		# end

		def get_gross_total()
			gross_total = 0
			order_category_list.each do |one_rec|
				gross_total += one_rec.category_total
			end

			gross_total
		end

		def get_charge_tax_code()
			chrg_code = ""
			tax_code = ""

			facility_rec = Facility::FacilityMaster.where(facility_code: facility_id).first
			if facility_rec
				chrg_code = facility_rec.bill_charge_code
				tax_code = facility_rec.bill_charge_tax_code
			end

			pp "Facility Charge Code ----------"
			pp chrg_code
			pp tax_code
			return chrg_code, tax_code
		end

		def facility_charge_exists
			@charge_code
		end
	end
end