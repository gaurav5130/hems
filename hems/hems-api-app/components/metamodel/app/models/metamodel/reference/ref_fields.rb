# == Schema Information
#
# Table name: ref_fields
#
#  id            :#<ActiveModel::T not null, primary key
#  ref_type      :#<ActiveModel::T
#  fld_name      :#<ActiveModel::T
#  title         :#<ActiveModel::T
#  fld_desc      :#<ActiveModel::T
#  fld_type      :#<ActiveModel::T
#  fld_size      :#<ActiveModel::T
#  sequence      :#<ActiveModel::T
#  validation    :#<ActiveModel::T
#  editable      :#<ActiveModel::T
#  default_val   :#<ActiveModel::T
#  is_additional :#<ActiveModel::T
#  created_at    :#<ActiveRecord:: not null
#  updated_at    :#<ActiveRecord:: not null
#

require_dependency "core/m_d_b_record"

module Metamodel
	module Reference
	  class RefFields < Core::MDBRecord
		def upcase_attrs
	  		["ref_type","title","fld_desc", "default_val"]
	  	end

	  	def downcase_attrs
	  		["fld_name", "fld_type", "validation"]
	  	end
	  end
	end
end
