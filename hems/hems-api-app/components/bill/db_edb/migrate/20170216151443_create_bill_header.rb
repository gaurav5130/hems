class CreateBillHeader < ActiveRecord::Migration[5.0]
  def change
    create_table :bill_header do |t|
      t.string :corporate_id, limit: 20
      t.string :establishment_id, limit: 20
      t.string :bill_number, limit: 30
      t.date :bill_date
      t.time :bill_time
      t.integer :tab_number
      t.string :facility_code, limit: 20
      t.string :order_number, limit:25
      t.datetime :order_date
      t.string :reservation_id
      t.float :total_published_amount
      t.float :discount_amount
      t.float :total_invoice_amount
      t.float :total_charges
      t.float :total_taxes
      t.float :total_payable
      t.float :original_total_payable
      t.float :discount_benefit_to_customer
      t.float :discount_round_off
      t.integer :member_id
      t.float :amount_collected
      t.string :discounts, limit: 2
      t.string :package_id, limit: 20
      t.string :payment_method, limit: 10
      t.string :payment_status, limit: 1
      t.string :created_by, limit: 50
      t.string :updated_by, limit: 50

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        add_index :bill_header, [:corporate_id, :establishment_id, :bill_date, :bill_number], :name => "bill_header_index", :unique => true 
      end
      dir.down do
        execute "DROP INDEX bill_header_index"
      end
    end
  end
end
