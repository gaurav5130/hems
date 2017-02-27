class CreateModuleHeader < ActiveRecord::Migration[5.0]
  def change
    create_table :module_header do |t|
      t.string 	:module_id, 	null: false
      t.string 	:title, 		null: false
      t.string 	:desc, 			null: false
      t.string 	:alias, 		null: false
      t.boolean :base_module, 	null: false
      t.boolean :ignore_auth, 	null: false
      t.boolean :migration_reqd,null: false

      t.timestamps null: false
    end
  end
end