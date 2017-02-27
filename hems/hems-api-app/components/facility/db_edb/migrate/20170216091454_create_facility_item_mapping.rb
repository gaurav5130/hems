class CreateFacilityItemMapping < ActiveRecord::Migration[5.0]
  def change
    create_table :facility_item_mapping do |t|
      t.string :corporate_id
      t.string :establishment_id
      t.string :facility_code
      t.string :item_code
      t.float :rack_rate
	  t.float :published_rate, :null=>false
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
	 reversible do |dir|
      dir.up do
        add_index :facility_item_mapping, [:facility_code, :item_code, :establishment_id, :corporate_id], :name => "facility_item_mapping_index", :unique => true 
      end
      dir.down do
        execute "DROP INDEX facility_item_mapping_index"
      end
    end
	
  end
end
