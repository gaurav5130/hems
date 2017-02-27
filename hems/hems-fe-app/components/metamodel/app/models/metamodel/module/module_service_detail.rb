require_dependency "core/m_d_b_record"

module Metamodel
	module Module
	  class ModuleServiceDetail < Core::MDBRecord
	    validates :module_id, :service_group_id, :service_id, :title, :desc, :presence => true
	  	validates :service_id, :uniqueness => {:scope => [:module_id, :service_group_id]}

	    def upcase_attrs
	    	["module_id", "service_group_id", "service_id", "title"]
	    end
	  end
	end
end