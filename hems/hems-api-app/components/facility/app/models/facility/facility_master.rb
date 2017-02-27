# == Schema Information
#
# Table name: facility_master
#
#  id                       :#<ActiveModel::T not null, primary key
#  corporate_id             :#<ActiveModel::T
#  establishment_id         :#<ActiveModel::T
#  facility_code            :#<ActiveModel::T
#  short_desc               :#<ActiveModel::T
#  long_desc                :#<ActiveModel::T
#  bill_charge_code         :#<ActiveModel::T
#  bill_charge_tax_code     :#<ActiveModel::T
#  consolidate_tax_for_bill :#<ActiveModel::T
#  city_of_operation        :#<ActiveModel::T
#  created_by               :#<ActiveModel::T
#  updated_by               :#<ActiveModel::T
#  created_at               :#<ActiveRecord:: not null
#  updated_at               :#<ActiveRecord:: not null
#
# Indexes
#
#  facility_master_index  (facility_code,establishment_id,corporate_id) UNIQUE
#

require_dependency "core/e_d_b_record"

module Facility
	class FacilityMaster < Core::EDBRecord
		def upcase_attrs
	  		["corporate_id","establishment_id","facility_code","short_desc","long_desc","bill_charge_code",
	  			"bill_charge_tax_code","city_of_operation","created_by","updated_by"]
	  	end
	end
end
