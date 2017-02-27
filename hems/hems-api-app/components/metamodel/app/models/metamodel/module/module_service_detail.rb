# == Schema Information
#
# Table name: module_service_detail
#
#  id               :#<ActiveModel::T not null, primary key
#  module_id        :#<ActiveModel::T not null
#  service_group_id :#<ActiveModel::T not null
#  service_id       :#<ActiveModel::T not null
#  title            :#<ActiveModel::T not null
#  desc             :#<ActiveModel::T not null
#  created_at       :#<ActiveRecord:: not null
#  updated_at       :#<ActiveRecord:: not null
#

require_dependency "core/m_d_b_record"

module Metamodel
	module Module
	  class ModuleServiceDetail < Core::MDBRecord
	    validates :module_id, :service_group_id, :service_id, :title, :desc, :presence => true
	  	validates :service_id, :uniqueness => {:scope => [:module_id, :service_group_id]}

	    def upcase_attrs
	    	["module_id", "service_group_id", "service_id", "title", "desc"]
	    end
	  end
	end
end
