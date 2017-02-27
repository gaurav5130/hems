class CreateRole < ActiveRecord::Migration[5.0]
  def change
    create_table :role do |t|
      t.string :corporate_id, null: false, default: ""
      t.string :establishment_id, null: false, default: ""
      t.string :code, null: false, default: ""
      t.string :desc, null: false, default: ""
      
      t.timestamps null: false
      t.string :created_by
      t.string :updated_by   
    end
  end
end
