# == Schema Information
#
# Table name: tax_charge_code_definition
#
#  id           :#<ActiveModel::T not null, primary key
#  corporate_id :#<ActiveModel::T
#  code         :#<ActiveModel::T
#  serial_no    :#<ActiveModel::T not null
#  component_id :#<ActiveModel::T
#  short_name   :#<ActiveModel::T
#  long_name    :#<ActiveModel::T
#  created_by   :#<ActiveModel::T
#  updated_by   :#<ActiveModel::T
#  created_at   :#<ActiveRecord:: not null
#  updated_at   :#<ActiveRecord:: not null
#
# Indexes
#
#  tax_charge_code_definition_index  (code,component_id,corporate_id) UNIQUE
#

require_dependency "core/e_d_b_record"

module TaxCharge
	class TaxChargeCodeDefinition < Core::EDBRecord
		def upcase_attrs
	  		["corporate_id","code","component_id","short_name","long_name","created_by","updated_by"]
	  	end
	end
end
