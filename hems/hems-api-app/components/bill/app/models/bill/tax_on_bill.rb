# == Schema Information
#
# Table name: tax_on_bill
#
#  id                :#<ActiveModel::T not null, primary key
#  bill_header_id    :#<ActiveModel::T
#  corporate_id      :#<ActiveModel::T
#  establishment_id  :#<ActiveModel::T
#  bill_number       :#<ActiveModel::T
#  bill_date         :#<ActiveRecord::
#  bill_time         :#<ActiveRecord::
#  tax_category_code :#<ActiveModel::T
#  tax_component_id  :#<ActiveModel::T
#  tax_serial_no     :#<ActiveModel::T
#  tax_payable       :#<ActiveModel::T
#  created_by        :#<ActiveModel::T
#  updated_by        :#<ActiveModel::T
#  created_at        :#<ActiveRecord:: not null
#  updated_at        :#<ActiveRecord:: not null
#
# Indexes
#
#  index_tax_on_bill_on_bill_header_id  (bill_header_id)
#  tax_on_bill_index                    (corporate_id,establishment_id,bill_date,bill_number,tax_category_code,tax_component_id) UNIQUE
#

require_dependency "core/e_d_b_record"

module Bill
  class TaxOnBill < Core::EDBRecord
	def upcase_attrs
  		["corporate_id","establishment_id","bill_number","tax_category_code","tax_component_id",
  			"created_by","updated_by"]
  	end
  end
end
