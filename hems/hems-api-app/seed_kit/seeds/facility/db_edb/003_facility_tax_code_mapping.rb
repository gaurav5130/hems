data_file = File.join(File.dirname(__FILE__), "data", File.basename(__FILE__).gsub(".rb", ".txt"))

Facility::FacilityTaxCodeMapping.delete_all

open(data_file).read.each_line do |line|
    corporate_id, establishment_id, facility_code, item_tax_category_code, tax_code= line.chomp.split(",")
	
    Facility::FacilityTaxCodeMapping.create!(corporate_id: corporate_id, establishment_id: establishment_id, facility_code: facility_code,item_tax_category_code: item_tax_category_code, tax_code: tax_code)
end