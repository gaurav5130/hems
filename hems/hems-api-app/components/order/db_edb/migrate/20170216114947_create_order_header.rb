class CreateOrderHeader < ActiveRecord::Migration[5.0]
	def up
		execute "CREATE SEQUENCE order_header_order_number_seq START 5000"
	    
	    create_table :order_header do |t|
		  t.string :corporate_id
	      t.string :establishment_id
	      t.integer :order_number
	      t.date :order_date
	      t.time :order_time
		  t.string :member_id, :null=>false
		  t.string :table_number, :null=>false
		  t.string :waitor
		  t.string :steward
		  t.string :tab_number
		  t.string :facility_code, :null=>false
		  t.string :order_status, :limit=>1
		  t.string :bill_number
		  t.string :package_id
		  t.string :reason_code
	      t.string :created_by
	      t.string :updated_by
	      t.timestamps
	    end
		
		execute <<-SQL
		   ALTER TABLE order_header ALTER COLUMN order_number SET DEFAULT nextval('order_header_order_number_seq');
	 	SQL
	
		add_index :order_header, [:order_number, :establishment_id, :corporate_id], :name => "order_header_index", :unique => true
	end

	def down
		execute <<-SQL
			ALTER SEQUENCE order_header_order_number_seq OWNED BY NONE;
			ALTER TABLE order_header ALTER COLUMN order_number SET NOT NULL;
		SQL
		execute "DROP INDEX order_header_index"
		execute "drop table order_header"
		execute "DROP SEQUENCE order_header_order_number_seq"
	end
end