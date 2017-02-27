class CreateBillDetail < ActiveRecord::Migration[5.0]
  def change
    create_table :bill_detail do |t|
      t.belongs_to :bill_header
      t.string :corporate_id, limit: 20
      t.string :establishment_id, limit: 20
      t.string :bill_number, limit: 30
      t.date :bill_date
      t.time :bill_time
      t.integer :bill_det_serial_no
      t.string :item_tax_category_code, limit: 10
      t.string :item_code, limit: 20
      t.float :quantity
      t.float :published_rate_per_unit
      t.float :published_rate_total
      t.float :discount
      t.float :invoice_amount
      t.string :discount_reason, limit: 10
      t.string :created_by, limit: 50
      t.string :updated_by, limit: 50

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        add_index :bill_detail, [:corporate_id, :establishment_id, :bill_date, :bill_number, :bill_det_serial_no], :name => "bill_detail_index", :unique => true 
      end
      dir.down do
        execute "DROP INDEX bill_detail_index"
      end
    end

  end
end