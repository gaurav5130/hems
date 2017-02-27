class CreateTaxChargeCodeDefinition < ActiveRecord::Migration[5.0]
  def change
    create_table :tax_charge_code_definition do |t|
      t.string :corporate_id
      t.string :code
      t.integer :serial_no, :null=>false
      t.string :component_id
      t.string :short_name
      t.string :long_name
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
	 reversible do |dir|
      dir.up do
       add_index :tax_charge_code_definition, [:code, :component_id, :corporate_id], :name => "tax_charge_code_definition_index", :unique => true
      end
      dir.down do
        execute "DROP INDEX tax_charge_code_definition_index"
      end
    end
	
  end
end
