data_file = File.join(File.dirname(__FILE__), "data", File.basename(__FILE__).gsub(".rb", ".txt"))

Facility::FacilityItemMapping.delete_all

open(data_file).read.each_line do |line|
    corporate_id, establishment_id, facility_code, item_code, rack_rate, published_rate = line.chomp.split(",")
	
    Facility::FacilityItemMapping.create!(corporate_id: corporate_id, establishment_id: establishment_id, facility_code: facility_code,item_code: item_code, rack_rate: rack_rate, published_rate: published_rate)
end