# == Schema Information
#
# Table name: bill_detail
#
#  id                      :#<ActiveModel::T not null, primary key
#  bill_header_id          :#<ActiveModel::T
#  corporate_id            :#<ActiveModel::T
#  establishment_id        :#<ActiveModel::T
#  bill_number             :#<ActiveModel::T
#  bill_date               :#<ActiveRecord::
#  bill_time               :#<ActiveRecord::
#  bill_det_serial_no      :#<ActiveModel::T
#  item_tax_category_code  :#<ActiveModel::T
#  item_code               :#<ActiveModel::T
#  quantity                :#<ActiveModel::T
#  published_rate_per_unit :#<ActiveModel::T
#  published_rate_total    :#<ActiveModel::T
#  discount                :#<ActiveModel::T
#  invoice_amount          :#<ActiveModel::T
#  discount_reason         :#<ActiveModel::T
#  created_by              :#<ActiveModel::T
#  updated_by              :#<ActiveModel::T
#  created_at              :#<ActiveRecord:: not null
#  updated_at              :#<ActiveRecord:: not null
#
# Indexes
#
#  bill_detail_index                    (corporate_id,establishment_id,bill_date,bill_number,bill_det_serial_no) UNIQUE
#  index_bill_detail_on_bill_header_id  (bill_header_id)
#

require_dependency "core/e_d_b_record"

module Bill
  class BillDetail < Core::EDBRecord
    def upcase_attrs
    	["corporate_id", "establishment_id", "bill_number", "item_tax_category_code", "item_code", "discount_reason",
    		"created_by","updated_by"]
    end
  end
end
