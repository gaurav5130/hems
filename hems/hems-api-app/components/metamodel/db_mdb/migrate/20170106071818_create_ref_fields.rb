class CreateRefFields < ActiveRecord::Migration[5.0]
  def change
    create_table :ref_fields do |t|
      t.string :ref_type, limit: 50
      t.string :fld_name, limit: 20
      t.string :title, limit: 50
      t.string :fld_desc, limit: 100
      t.string :fld_type, limit: 20
      t.integer :fld_size, limit: 5
      t.integer :sequence, limit: 5
      t.string :validation, limit: 255
      t.boolean :editable
      t.string :default_val, limit: 50
      t.boolean :is_additional
      
      t.timestamps
    end
  end
end
