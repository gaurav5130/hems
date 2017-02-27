class CreateOrderDetail < ActiveRecord::Migration[5.0]
	 def change
	   create_table :order_detail do |t|
		t.string :corporate_id
		t.string :establishment_id
		t.integer :order_number
		t.date :order_date, :null=>false
		t.time :order_time, :null=>false
		t.integer :serial_number, :null=>false
		t.integer :ot_number,		:null=>false
		t.datetime :ot_datetime
		t.string :item_code, 		:null=>false
		t.float :quantity
		t.string :validity
		t.string :created_by
		t.string :updated_by
		t.timestamps
    end

	 reversible do |dir|
      dir.up do
        add_index :order_detail, [:order_number, :ot_number, :serial_number, :establishment_id, :corporate_id], :name => "order_detail_index", :unique => true
      end
      dir.down do
        execute "DROP INDEX order_detail_index"
      end
    end
	
  end
end


	
