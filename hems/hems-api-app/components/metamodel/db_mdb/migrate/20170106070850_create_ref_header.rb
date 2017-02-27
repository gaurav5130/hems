class CreateRefHeader < ActiveRecord::Migration[5.0]
  def change
    create_table :ref_header do |t|
      t.string :ref_type, limit: 50
      t.string :title, limit: 50
      t.string :description, limit: 255
      t.string :category, limit: 50
      t.boolean :overridden_fields
      t.boolean :additional_fields

      t.timestamps
    end
  end
end
