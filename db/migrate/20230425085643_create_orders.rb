class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string  :invoice_number
      t.decimal :total_price, precision: 8, scale: 2 
      t.integer :user_id
      t.timestamps
    end
  end
end
