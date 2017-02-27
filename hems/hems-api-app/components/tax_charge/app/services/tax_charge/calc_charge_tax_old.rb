module TaxCharge
	class CalcChargeTaxOld < Core::BaseService
		class TypeDoNotMatchError < StandardError; end
		class InvalidCalcTypeError < StandardError; end
		class ComponentNotFoundError < StandardError; end
		class InvalidRateTypeError < StandardError; end
		class SlabNotMetError < StandardError; end

		include Virtus.model
		include ActiveModel::Validations

		attribute :vo, 			ChargeTaxInputVO
		attribute :comp_list, 	Array[ChargeTaxComponentVO], 	:writer => :private
		attribute :tot_amt, 	Float,							:writer => :private	

		def initialize(vo)
			#Contains - code, charge_amt, rack_amt, type
			@vo = vo
			@comp_list = []
			@tot_amt = 0
		end

		def validate()
			@vo.valid?
		end
		
		def process()
			result_set = TaxChargeCodeDefinition.where(code: vo.code, corporate_id: @context.corporate_id)
							.order(:serial_no)
			result_set.each do |one_rec|
				#Contains - code, serial_no, component_id, chargeOrTax, ShortTaxName, LongTaxName
				comp_rec = get_component(one_rec.component_id)
				p "printing component_id"
				p comp_rec
				comp_amt = calculate(comp_rec, comp_rec.calculation_type)

				@tot_amt += comp_amt
				result_rec = ChargeTaxComponentVO.new(comp_id: one_rec.component_id, type: comp_rec.charge_or_tax, 
							title: comp_rec.long_name, calc_amt: comp_amt, rounded_amt: comp_amt)
					#Rounded_Amt is intentionally put as calc_amt bcoz rounding happens at the end, instead of keeping the amount as zero.
				@comp_list << result_rec
			end

			ChargeTaxSummaryVO.new(tot_amt: @tot_amt, comp_list: @comp_list)
		end

		def get_component(component_id)
			comp_rec = TaxChargeComponentMaster.where(component_id: component_id, 
					corporate_id: @context.corporate_id,
					establishment_id: @context.establishment_id).first
			#Contains - component_id, serial_no, short_name, long_name, comp_type (T or C), pcnt_fixed (P or F or S), .. 
			unless comp_rec
				raise ComponentNotFoundError.new "Component not found for (#{component_id})"
			end
			
			unless (comp_rec.charge_or_tax == vo.type)
				p vo.type
				p comp_rec.charge_or_tax
				raise TypeDoNotMatchError.new "Component Type (#{comp_rec.charge_or_tax}) of Component ID (#{comp_rec.component_id}) do not match with Computation Type (#{vo.type}))"
			end

			comp_rec
		end

		def calculate(comp_rec, calcType)
			case calcType
			when "F"
				amt = fixed(comp_rec)
			when "P"
				amt = percentage(comp_rec)
			when "S"
				amt = slab(comp_rec.component_id)
			else
				raise InvalidCalcTypeError.new "Invalid calculation type for Component ID (#{comp_rec.component_id}). It should be Percentage / Fixed / Slab."
			end
			p 'printing comp amount'
			p amt
			comp_amt = applyMinMax(amt, comp_rec)
			p 'printing comp amount'
			p comp_amt
			comp_amt
		end

		def fixed(comp_rec)
			comp_rec.applicable_amount
		end

		def percentage(comp_rec)
			price = get_price(comp_rec)
			pcnt = comp_rec.applicable_amount

			(price * pcnt) / 100
		end

		def slab(component_id)
			result_set = TaxChargeComponentMaster.where(component_id: component_id, 
					corporate_id: @context.corporate_id,
					establishment_id: @context.establishment_id)

			price = 0
			comp_rec = nil
			result_set.each do |one_rec|
				price = get_price(one_rec)
				if one_rec.slab_start_amount <= price && price <= one_rec.slab_end_amount
					comp_rec = one_rec
					break
				end
			end

			unless comp_rec
				raise SlabNotMetError.new "Slab range not met for amount (#{price}) for component id (#{component_id})"
			end	

			unless (comp_rec.slab_calculation_type != 'S')
				raise InvalidCalcTypeError.new "Invalid calculation type for Component ID (#{component_id}). It should be Percentage / Fixed."
			end

			comp_amt = calculate(comp_rec, comp_rec.slab_calculation_type)

			comp_amt
		end

		def get_price(comp_rec)
			price = 0
			case comp_rec.applied_on_rate
			when "C"
				price = vo.charge_rate
			when "R"
				price = vo.rack_rate
			else
				raise "InvalidRateTypeError".new "Invalid rate type for Component ID (#{comp_rec.component_id}). It should be Rack / Charge Rate."
			end
			p 'printing price'
			p price
			price
		end

		def applyMinMax(amt, comp_rec)
			ret = amt
			p 'in min max'
			
			if (amt < comp_rec.minimum_tax_amount)
				ret = comp_rec.minimum_tax_amount
			end
			if (amt > comp_rec.maximum_tax_amount)
				ret = comp_rec.maximum_tax_amount
			end
			p ret
			ret
		end
	end
end