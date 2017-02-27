class CreateRoleAccess < ActiveRecord::Migration[5.0]
  def change
    create_table :role_access do |t|
      t.string 	:corporate_id, 		null: false
      t.string 	:establishment_id, 	null: false
      t.string 	:module_id, 		null: false
      t.string 	:service_group_id, 	null: false
      t.string 	:service_id,	 	null: false
      t.string  :access_groups, null: false
      
      t.timestamps 	null: false
      t.string :created_by
      t.string :updated_by   
    end

    # add_column :role_access, :access_groups, :string, default: '{}'
  end
end
