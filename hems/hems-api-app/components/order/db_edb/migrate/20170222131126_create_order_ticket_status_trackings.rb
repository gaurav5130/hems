class CreateOrderTicketStatusTrackings < ActiveRecord::Migration[5.0]
  def change
    create_table :order_ticket_status_tracking do |t|
      t.string :corporate_id
      t.string :establishment_id
      t.integer :ot_number
      t.datetime :ot_datetime
      t.string :item_code
      t.float :quantity
      t.string :ot_status, :null=>false
      t.time :ot_updated_time
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end

	 reversible do |dir|
      dir.up do
        add_index :order_ticket_status_tracking, [:ot_number, :item_code, :establishment_id, :corporate_id], :name => "order_ticket_status_tracking_index", :unique => true
      end
      dir.down do
        execute "DROP INDEX order_ticket_status_tracking_index"
      end
    end
	
  end
end