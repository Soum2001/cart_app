class AddProductToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :order_items, :products
  end
end
