# == Schema Information
#
# Table name: ref_codes
#
#  id               :#<ActiveModel::T not null, primary key
#  corporate_id     :#<ActiveModel::T
#  establishment_id :#<ActiveModel::T
#  ref_type         :#<ActiveModel::T
#  code             :#<ActiveModel::T
#  desc             :#<ActiveModel::T
#  alt_desc         :#<ActiveModel::T
#  short_desc       :#<ActiveModel::T
#  additional_data  :#<ActiveRecord::
#  created_by       :#<ActiveModel::T
#  updated_by       :#<ActiveModel::T
#  created_at       :#<ActiveRecord:: not null
#  updated_at       :#<ActiveRecord:: not null
#

require_dependency "core/e_d_b_record"

module Reference
	class RefCodes < Core::EDBRecord
	    def upcase_attrs
	    	["corporate_id", "establishment_id", "ref_type", "code", "desc", "alt_desc", "short_desc", "created_by","updated_by"]
	    end
	end
end
