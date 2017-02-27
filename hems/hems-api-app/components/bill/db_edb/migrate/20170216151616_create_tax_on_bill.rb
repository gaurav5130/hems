class CreateTaxOnBill < ActiveRecord::Migration[5.0]
  def change
    create_table :tax_on_bill do |t|
      t.belongs_to :bill_header
      t.string :corporate_id, limit: 20
      t.string :establishment_id, limit: 20
      t.string :bill_number, limit: 30
      t.date :bill_date
      t.time :bill_time
      t.string :tax_category_code, limit: 20
      t.string :tax_component_id, limit: 20
      t.integer :tax_serial_no
      t.float :tax_payable
      t.string :created_by, limit: 50
      t.string :updated_by, limit: 50

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        add_index :tax_on_bill, [:corporate_id, :establishment_id, :bill_date, :bill_number, :tax_category_code , :tax_component_id], :name => "tax_on_bill_index", :unique => true 
      end
      dir.down do
        execute "DROP INDEX tax_on_bill_index"
      end
    end

  end
end
