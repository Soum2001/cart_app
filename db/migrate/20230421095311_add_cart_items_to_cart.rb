class AddCartItemsToCart < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :cart_items, :carts
  end
end