class CreateTaxChargeComponentMaster < ActiveRecord::Migration[5.0]
  def change
    create_table :tax_charge_component_master do |t|
      t.string :corporate_id
      t.string :establishment_id
      t.string :component_id
      t.string :charge_or_tax, :limit=>1, :null=>false
      t.string :calculation_type, :limit=>1, :null=>false
      t.integer :serial_no
      t.string :short_name
      t.string :long_name
      t.float :applicable_amount,  :null=>false
      t.string :applied_on_rate, :limit=>1, :null=>false
      t.string :round_off_to
      t.string :round_off_to_num
      t.float :slab_start_amount
      t.float :slab_end_amount
      t.string :slab_calculation_type
      t.float :slab_applicable_amount
      t.float :minimum_tax_amount, :null=>false
      t.float :maximum_tax_amount, :null=>false
      t.string :gl_detail
      t.string :country
      t.string :state
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
	 reversible do |dir|
      dir.up do
        add_index :tax_charge_component_master, [:component_id, :serial_no, :establishment_id, :corporate_id], :name => "tax_charge_component_master_index", :unique => true
      end
      dir.down do
        execute "DROP INDEX tax_charge_component_master_index"
      end
    end
	
  end
end
