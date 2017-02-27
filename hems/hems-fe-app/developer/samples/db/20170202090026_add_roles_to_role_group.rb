class AddRolesToRoleGroup < ActiveRecord::Migration[5.0]
  def change
  	add_column :role_group, :user_roles, :string, default: '{}'
  end
end
