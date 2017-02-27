# == Schema Information
#
# Table name: role
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
#

require_dependency "core/e_d_b_record"

module Auth
  class Role < Core::EDBRecord
  	validates :corporate_id, :establishment_id, :code, :desc, :presence => true
  	validates :code, :uniqueness => {:scope => [:corporate_id, :establishment_id]}

    def upcase_attrs
    	["corporate_id", "establishment_id", "code", "desc","created_by","updated_by"]
    end
  end
end
