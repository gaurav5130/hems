# == Schema Information
#
# Table name: ref_header
#
#  id                :#<ActiveModel::T not null, primary key
#  ref_type          :#<ActiveModel::T
#  title             :#<ActiveModel::T
#  description       :#<ActiveModel::T
#  category          :#<ActiveModel::T
#  overridden_fields :#<ActiveModel::T
#  additional_fields :#<ActiveModel::T
#  created_at        :#<ActiveRecord:: not null
#  updated_at        :#<ActiveRecord:: not null
#

require_dependency "core/m_d_b_record"

module Metamodel
	module Reference
	  class RefHeader < Core::MDBRecord
		def upcase_attrs
	  		["ref_type","title","description","category"]
	  	end
	  end
	end
end
