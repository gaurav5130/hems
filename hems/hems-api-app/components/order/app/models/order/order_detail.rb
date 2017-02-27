# == Schema Information
#
# Table name: order_detail
#
#  id               :#<ActiveModel::T not null, primary key
#  corporate_id     :#<ActiveModel::T
#  establishment_id :#<ActiveModel::T
#  order_number     :#<ActiveModel::T
#  order_date       :#<ActiveRecord:: not null
#  order_time       :#<ActiveRecord:: not null
#  serial_number    :#<ActiveModel::T not null
#  ot_number        :#<ActiveModel::T not null
#  ot_datetime      :#<ActiveRecord::
#  item_code        :#<ActiveModel::T not null
#  quantity         :#<ActiveModel::T
#  validity         :#<ActiveModel::T
#  created_by       :#<ActiveModel::T
#  updated_by       :#<ActiveModel::T
#  created_at       :#<ActiveRecord:: not null
#  updated_at       :#<ActiveRecord:: not null
#
# Indexes
#
#  order_detail_index  (order_number,ot_number,establishment_id,corporate_id) UNIQUE
#

require_dependency "core/e_d_b_record"

module Order
	class OrderDetail < Core::EDBRecord
		def upcase_attrs
	  		["corporate_id","establishment_id","item_code","validity","created_by","updated_by"]
	  	end
	end
end
