data_file = File.join(File.dirname(__FILE__), "data", File.basename(__FILE__).gsub(".rb", ".txt"))

Facility::FacilityMaster.delete_all

open(data_file).read.each_line do |line|
    corporate_id, establishment_id, facility_code, short_desc,long_desc, bill_charge_code, bill_charge_tax_code, consolidate_tax_for_bill  = line.chomp.split(",")
	
    Facility::FacilityMaster.create!(corporate_id: corporate_id, establishment_id: establishment_id, facility_code: facility_code,short_desc: short_desc, long_desc: long_desc, bill_charge_code: bill_charge_code, bill_charge_tax_code: bill_charge_tax_code, consolidate_tax_for_bill: consolidate_tax_for_bill)
end


