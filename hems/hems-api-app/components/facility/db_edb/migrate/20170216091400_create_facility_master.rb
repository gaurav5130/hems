class CreateFacilityMaster < ActiveRecord::Migration[5.0]
  def change
    create_table :facility_master do |t|
      t.string :corporate_id
      t.string :establishment_id
      t.string :facility_code
      t.string :short_desc
      t.string :long_desc
      t.string :bill_charge_code
      t.string :bill_charge_tax_code
      t.boolean :consolidate_tax_for_bill
	    t.string	:city_of_operation
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
	 reversible do |dir|
      dir.up do
        add_index :facility_master, [:facility_code, :establishment_id, :corporate_id], :name => "facility_master_index", :unique => true
      end
      dir.down do
        execute "DROP INDEX facility_master_index"
      end
    end
	
  end
end
