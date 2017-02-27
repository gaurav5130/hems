data_file = File.join(File.dirname(__FILE__), "data", File.basename(__FILE__).gsub(".rb", ".txt"))

Items::SalesItemDetail.delete_all

#  item_code          :#<ActiveModel::T
#  item_type          :#<ActiveModel::T
#  short_name         :#<ActiveModel::T
#  long_name          :#<ActiveModel::T
#  tax_category_code  :#<ActiveModel::T not null
#  inventory_category :#<ActiveModel::T
#  sell_status        :#<ActiveModel::T

open(data_file).read.each_line do |line|
    corporate_id, establishment_id, item_code, item_type, short_name, long_name, tax_category_code = line.chomp.split(",")
	
    Items::SalesItemDetail.create!(corporate_id: corporate_id, establishment_id: establishment_id, item_code: item_code,item_type: item_type, short_name: short_name, long_name: long_name, tax_category_code: tax_category_code)
end