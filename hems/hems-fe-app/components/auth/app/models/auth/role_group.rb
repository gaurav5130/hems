# == Schema Information
#
# Table name: role_group
#
#  id               :#<ActiveModel::T not null, primary key
#  corporate_id     :#<ActiveModel::T default(""), not null
#  establishment_id :#<ActiveModel::T default(""), not null
#  code             :#<ActiveModel::T default(""), not null
#  desc             :#<ActiveModel::T default(""), not null
#  created_at       :#<ActiveRecord:: not null
#  updated_at       :#<ActiveRecord:: not null
#  created_by       :#<ActiveModel::T
#  updated_by       :#<ActiveModel::T
#  user_roles       :#<ActiveModel::T default("{}")
#

require_dependency "core/e_d_b_record"

module Auth
  class RoleGroup < Core::EDBRecord
    serialize :user_roles, Array

  	validates :corporate_id, :establishment_id, :code, :desc, :user_roles, :presence => true
  	validates :code, :uniqueness => {:scope => [:corporate_id, :establishment_id]}

    def upcase_attrs
    	["corporate_id", "establishment_id", "desc"]
    end

    def downcase_attrs
    	["code"]
    end
  end
end
