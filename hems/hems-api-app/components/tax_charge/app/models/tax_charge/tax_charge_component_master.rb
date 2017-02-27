# == Schema Information
#
# Table name: tax_charge_component_master
#
#  id                     :#<ActiveModel::T not null, primary key
#  corporate_id           :#<ActiveModel::T
#  establishment_id       :#<ActiveModel::T
#  component_id           :#<ActiveModel::T
#  charge_or_tax          :#<ActiveModel::T not null
#  calculation_type       :#<ActiveModel::T not null
#  serial_no              :#<ActiveModel::T
#  short_name             :#<ActiveModel::T
#  long_name              :#<ActiveModel::T
#  applicable_amount      :#<ActiveModel::T not null
#  applied_on_rate        :#<ActiveModel::T not null
#  round_off_to           :#<ActiveModel::T
#  round_off_to_num       :#<ActiveModel::T
#  slab_start_amount      :#<ActiveModel::T
#  slab_end_amount        :#<ActiveModel::T
#  slab_calculation_type  :#<ActiveModel::T
#  slab_applicable_amount :#<ActiveModel::T
#  minimum_tax_amount     :#<ActiveModel::T not null
#  maximum_tax_amount     :#<ActiveModel::T not null
#  gl_detail              :#<ActiveModel::T
#  country                :#<ActiveModel::T
#  state                  :#<ActiveModel::T
#  created_by             :#<ActiveModel::T
#  updated_by             :#<ActiveModel::T
#  created_at             :#<ActiveRecord:: not null
#  updated_at             :#<ActiveRecord:: not null
#
# Indexes
#
#  tax_charge_component_master_index  (component_id,serial_no,establishment_id,corporate_id) UNIQUE
#

require_dependency "core/e_d_b_record"

module TaxCharge
	class TaxChargeComponentMaster < Core::EDBRecord
	    def upcase_attrs
	    	["corporate_id","establishment_id","component_id", "short_name","long_name", "charge_or_tax",
	    		"calculation_type", "applied_on_rate", "round_off_to", "round_off_to_num",
	    		"slab_calculation_type", "gl_detail", "country","state", "created_by", "updated_by"]
	    end
	end
end
