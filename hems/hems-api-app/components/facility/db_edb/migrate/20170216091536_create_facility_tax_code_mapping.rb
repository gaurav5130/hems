class CreateFacilityTaxCodeMapping < ActiveRecord::Migration[5.0]
  def change
    create_table :facility_tax_code_mapping do |t|
      t.string :corporate_id
      t.string :establishment_id
      t.string :facility_code
      t.string :item_tax_category_code
      t.string :tax_code, :null=>false
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
	 reversible do |dir|
      dir.up do
        add_index :facility_tax_code_mapping, [:facility_code, :item_tax_category_code, :establishment_id, :corporate_id], :name => "facility_tax_code_mapping_index", :unique => true
      end
      dir.down do
        execute "DROP INDEX facility_tax_code_mapping_index"
      end
    end
	
  end
end
