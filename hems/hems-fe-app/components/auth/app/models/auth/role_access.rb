# == Schema Information
#
# Table name: role_access
#
#  id               :#<ActiveModel::T not null, primary key
#  corporate_id     :#<ActiveModel::T not null
#  establishment_id :#<ActiveModel::T not null
#  module_id        :#<ActiveModel::T not null
#  service_group_id :#<ActiveModel::T not null
#  service_id       :#<ActiveModel::T not null
#  access_groups    :#<ActiveModel::T not null
#  created_at       :#<ActiveRecord:: not null
#  updated_at       :#<ActiveRecord:: not null
#  created_by       :#<ActiveModel::T
#  updated_by       :#<ActiveModel::T
#

require_dependency "core/e_d_b_record"

module Auth
  class RoleAccess < Core::EDBRecord
    # serialize :access_groups, Array

  	validates :corporate_id, :establishment_id, :module_id, :service_group_id, :service_id, :access_groups, :presence => true

    def upcase_attrs
    	["corporate_id", "establishment_id", "module_id", "service_group_id", "service_id"]
    end
  end
end
