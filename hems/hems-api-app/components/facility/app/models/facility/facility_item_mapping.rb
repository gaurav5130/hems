# == Schema Information
#
# Table name: facility_item_mapping
#
#  id               :#<ActiveModel::T not null, primary key
#  corporate_id     :#<ActiveModel::T
#  establishment_id :#<ActiveModel::T
#  facility_code    :#<ActiveModel::T
#  item_code        :#<ActiveModel::T
#  rack_rate        :#<ActiveModel::T
#  published_rate   :#<ActiveModel::T not null
#  created_by       :#<ActiveModel::T
#  updated_by       :#<ActiveModel::T
#  created_at       :#<ActiveRecord:: not null
#  updated_at       :#<ActiveRecord:: not null
#
# Indexes
#
#  facility_item_mapping_index  (facility_code,item_code,establishment_id,corporate_id) UNIQUE
#

require_dependency "core/e_d_b_record"

module Facility
	class FacilityItemMapping < Core::EDBRecord
		def upcase_attrs
	  		["corporate_id","establishment_id","facility_code","item_code","created_by","updated_by"]
	  	end
	end
end
