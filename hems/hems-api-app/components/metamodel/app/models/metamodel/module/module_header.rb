# == Schema Information
#
# Table name: module_header
#
#  id             :#<ActiveModel::T not null, primary key
#  module_id      :#<ActiveModel::T not null
#  title          :#<ActiveModel::T not null
#  desc           :#<ActiveModel::T not null
#  alias          :#<ActiveModel::T not null
#  base_module    :#<ActiveModel::T not null
#  ignore_auth    :#<ActiveModel::T not null
#  migration_reqd :#<ActiveModel::T not null
#  created_at     :#<ActiveRecord:: not null
#  updated_at     :#<ActiveRecord:: not null
#

require_dependency "core/m_d_b_record"

module Metamodel
	module Module
	  class ModuleHeader < Core::MDBRecord
	    validates :module_id, :title, :desc, :alias, :presence => true
	  	validates :module_id, :uniqueness => true
	  	validates :base_module, :ignore_auth, :migration_reqd,  inclusion: { in: [true, false] }

	    def upcase_attrs
	    	["module_id", "title", "desc", "alias"]
	    end
	  end
	end
end
