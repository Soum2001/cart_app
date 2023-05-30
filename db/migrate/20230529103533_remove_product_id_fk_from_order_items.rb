class RemoveProductIdFkFromOrderItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :order_items, :product_id, :integer
  end
end
