require_dependency "core/m_d_b_record"

module Metamodel
	module Module
	  class ModuleHeader < Core::MDBRecord
	    validates :module_id, :title, :desc, :alias, :presence => true
	  	validates :module_id, :uniqueness => true
	  	validates :base_module, :ignore_auth, :migration_reqd,  inclusion: { in: [true, false] }

	    def upcase_attrs
	    	["module_id", "title", "alias"]
	    end
	  end
	end
end