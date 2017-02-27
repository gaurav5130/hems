class CreateSalesItemDetail < ActiveRecord::Migration[5.0]
  def change
    create_table :sales_item_detail do |t|
      t.string :corporate_id
      t.string :establishment_id
      t.string :item_code
      t.string :item_type
      t.string :short_name
      t.string :long_name
      t.string :tax_category_code, :null=>false
      t.string :inventory_category
	  t.string :sell_status,	:limit=>1
	  t.timestamps :start_date
	  t.timestamps :end_date
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end

	 reversible do |dir|
      dir.up do
        add_index :sales_item_detail, [:item_code, :establishment_id, :corporate_id], :name => "sales_item_detail_index", :unique => true
      end
      dir.down do
        execute "DROP INDEX sales_item_detail_index"
      end
    end
	
  end
end
