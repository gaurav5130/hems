# == Schema Information
#
# Table name: users
#
#  id                 :#<ActiveModel::T not null, primary key
#  corporate_id       :#<ActiveModel::T default(""), not null
#  establishment_id   :#<ActiveModel::T default(""), not null
#  user_id            :#<ActiveModel::T default(""), not null
#  user_name          :#<ActiveModel::T default(""), not null
#  role               :#<ActiveModel::T default(""), not null
#  email              :#<ActiveModel::T default(""), not null
#  encrypted_password :#<ActiveModel::T default(""), not null
#  sign_in_count      :#<ActiveModel::T default(0), not null
#  current_sign_in_at :#<ActiveRecord::
#  last_sign_in_at    :#<ActiveRecord::
#  current_sign_in_ip :#<ActiveModel::T
#  last_sign_in_ip    :#<ActiveModel::T
#  failed_attempts    :#<ActiveModel::T default(0), not null
#  locked_at          :#<ActiveRecord::
#  created_at         :#<ActiveRecord:: not null
#  updated_at         :#<ActiveRecord:: not null
#

require_dependency "core/e_d_b_record"

module Auth
  class Users < Core::EDBRecord
  	validates :corporate_id, :establishment_id, :user_id, :presence => true
  	validates :user_id, :numericality => { only_integer: true }, :uniqueness => {:scope => [:corporate_id, :establishment_id]}

    # Included default devise modules. Others available are:
    # :omniauthable, :confirmable, :rememberable, :validatable, :recoverable
    devise :database_authenticatable, :trackable, :timeoutable, :lockable, :registerable

    def upcase_attrs
    	["corporate_id", "establishment_id", "user_id", "user_name", "role"]
    end

    def downcase_attrs
      ["email"]
    end
  end
end
