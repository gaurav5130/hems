# == Schema Information
#
# Table name: module_service_header
#
#  id               :#<ActiveModel::T not null, primary key
#  module_id        :#<ActiveModel::T not null
#  service_group_id :#<ActiveModel::T not null
#  title            :#<ActiveModel::T not null
#  desc             :#<ActiveModel::T not null
#  created_at       :#<ActiveRecord:: not null
#  updated_at       :#<ActiveRecord:: not null
#

require_dependency "core/m_d_b_record"

module Metamodel
	module Module
	  class ModuleServiceHeader < Core::MDBRecord
	    validates :module_id, :service_group_id, :title, :desc, :presence => true
	  	validates :service_group_id, :uniqueness => {:scope => [:module_id]}

	    def upcase_attrs
	    	["module_id", "service_group_id", "title", "desc"]
	    end
	  end
	end
end
