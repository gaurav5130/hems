class CreateModuleServiceHeader < ActiveRecord::Migration[5.0]
  def change
    create_table :module_service_header do |t|
      t.string 	:module_id, 		null: false
      t.string 	:service_group_id, 	null: false
      t.string 	:title, 			null: false
      t.string 	:desc, 				null: false

      t.timestamps null: false
    end
  end
end
