class AddProductIdToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :product_id, :integer
    add_foreign_key :order_items, :products, column: :product_id
  end
end
