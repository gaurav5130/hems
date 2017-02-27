class CreateRefCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :ref_codes do |t|
      t.string :corporate_id, limit: 5
      t.string :establishment_id, limit: 5
      t.string :ref_type, limit: 20
      t.string :code, limit: 20
      t.string :desc, limit: 200
      t.string :alt_desc, limit: 200
      t.string :short_desc, limit: 50
      t.json :additional_data
      t.string :created_by, limit: 50
      t.string :updated_by, limit: 50

      t.timestamps
    end
  end
end