# == Schema Information
#
# Table name: order_header
#
#  id               :#<ActiveModel::T not null, primary key
#  corporate_id     :#<ActiveModel::T
#  establishment_id :#<ActiveModel::T
#  order_number     :#<ActiveModel::T
#  order_date       :#<ActiveRecord::
#  order_time       :#<ActiveRecord::
#  member_id        :#<ActiveModel::T not null
#  table_number     :#<ActiveModel::T not null
#  waitor           :#<ActiveModel::T
#  steward          :#<ActiveModel::T
#  tab_number       :#<ActiveModel::T
#  facility_code    :#<ActiveModel::T not null
#  order_status     :#<ActiveModel::T
#  bill_number      :#<ActiveModel::T
#  package_id       :#<ActiveModel::T
#  reason_code      :#<ActiveModel::T
#  created_by       :#<ActiveModel::T
#  updated_by       :#<ActiveModel::T
#  created_at       :#<ActiveRecord:: not null
#  updated_at       :#<ActiveRecord:: not null
#
# Indexes
#
#  order_header_index  (order_number,establishment_id,corporate_id) UNIQUE
#

require_dependency "core/e_d_b_record"

module Order
	class OrderHeader < Core::EDBRecord
		def upcase_attrs
	  		["corporate_id","establishment_id","member_id","table_number","waitor","steward","tab_number",
	  			"facility_code","order_status","bill_number","package_id","reason_code","created_by","updated_by"]
	  	end
	end
end
