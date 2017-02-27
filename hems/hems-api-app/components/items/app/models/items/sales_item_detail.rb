# == Schema Information
#
# Table name: sales_item_detail
#
#  id                 :#<ActiveModel::T not null, primary key
#  corporate_id       :#<ActiveModel::T
#  establishment_id   :#<ActiveModel::T
#  item_code          :#<ActiveModel::T
#  item_type          :#<ActiveModel::T
#  short_name         :#<ActiveModel::T
#  long_name          :#<ActiveModel::T
#  tax_category_code  :#<ActiveModel::T not null
#  inventory_category :#<ActiveModel::T
#  sell_status        :#<ActiveModel::T
#  created_at         :#<ActiveRecord:: not null
#  updated_at         :#<ActiveRecord:: not null
#  created_by         :#<ActiveModel::T
#  updated_by         :#<ActiveModel::T
#
# Indexes
#
#  sales_item_detail_index  (item_code,establishment_id,corporate_id) UNIQUE
#

require_dependency "core/e_d_b_record"

module Items
	class SalesItemDetail < Core::EDBRecord
		def upcase_attrs
	  		["corporate_id","establishment_id","item_code","item_type","short_name","long_name",
	  			"tax_category_code","inventory_category","sell_status","created_by","updated_by"]
	  	end
	end
end
