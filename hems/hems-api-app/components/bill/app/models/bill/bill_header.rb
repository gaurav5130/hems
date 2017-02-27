# == Schema Information
#
# Table name: bill_header
#
#  id                     :#<ActiveModel::T not null, primary key
#  corporate_id           :#<ActiveModel::T
#  establishment_id       :#<ActiveModel::T
#  bill_number            :#<ActiveModel::T
#  bill_date              :#<ActiveRecord::
#  bill_time              :#<ActiveRecord::
#  tab_number             :#<ActiveModel::T
#  facility_code          :#<ActiveModel::T
#  order_number           :#<ActiveModel::T
#  order_date             :#<ActiveRecord::
#  reservation_id         :#<ActiveModel::T
#  total_published_amount :#<ActiveModel::T
#  discount_amount        :#<ActiveModel::T
#  total_invoice_amount   :#<ActiveModel::T
#  total_charges          :#<ActiveModel::T
#  total_taxes            :#<ActiveModel::T
#  total_payable          :#<ActiveModel::T
#  member_id              :#<ActiveModel::T
#  amount_collected       :#<ActiveModel::T
#  discounts              :#<ActiveModel::T
#  package_id             :#<ActiveModel::T
#  payment_method         :#<ActiveModel::T
#  payment_status         :#<ActiveModel::T
#  created_by             :#<ActiveModel::T
#  updated_by             :#<ActiveModel::T
#  created_at             :#<ActiveRecord:: not null
#  updated_at             :#<ActiveRecord:: not null
#
# Indexes
#
#  bill_header_index  (corporate_id,establishment_id,bill_date,bill_number) UNIQUE
#

require_dependency "core/e_d_b_record"

module Bill
  class BillHeader < Core::EDBRecord
  	def upcase_attrs
  		["corporate_id","establishment_id","bill_number","facility_code","order_number","reservation_id","discounts","package_id","payment_method","payment_status","created_by","updated_by"]
  	end
  end
end
