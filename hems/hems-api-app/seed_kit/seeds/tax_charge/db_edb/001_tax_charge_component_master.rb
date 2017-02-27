data_file = File.join(File.dirname(__FILE__), "data", File.basename(__FILE__).gsub(".rb", ".txt"))

TaxCharge::TaxChargeComponentMaster.delete_all

open(data_file).read.each_line do |line|
	corporate_id, establishment_id, component_id, charge_or_tax, calculation_type, serial_no, short_name,long_name, applicable_amount, applied_on_rate, round_off_to, round_off_to_num, slab_start_amount, slab_end_amount, slab_calculation_type, slab_applicable_amount,minimum_tax_amount,maximum_tax_amount,gl_detail, country, state= line.chomp.split(",")
	TaxCharge::TaxChargeComponentMaster.create!(corporate_id: corporate_id, establishment_id: establishment_id, component_id: component_id, charge_or_tax: charge_or_tax, calculation_type: calculation_type, serial_no:serial_no, short_name: short_name, long_name: long_name, applicable_amount: applicable_amount, applied_on_rate:applied_on_rate, round_off_to:round_off_to, round_off_to_num:round_off_to_num, slab_start_amount: slab_start_amount, slab_end_amount:slab_end_amount, slab_calculation_type: slab_calculation_type, slab_applicable_amount: slab_applicable_amount, minimum_tax_amount: minimum_tax_amount, maximum_tax_amount: maximum_tax_amount, gl_detail: gl_detail, country: country, state: state)
end