class CreateRoleGroup < ActiveRecord::Migration[5.0]
  def change
    create_table :role_group do |t|
      t.string :corporate_id, null: false, default: ""
      t.string :establishment_id, null: false, default: ""
      t.string :code, null: false, default: ""
      t.string :desc, null: false, default: ""

      t.timestamps null: false   
    end

    add_column :role_group, :user_roles, :string, default: '{}'
  end
end
