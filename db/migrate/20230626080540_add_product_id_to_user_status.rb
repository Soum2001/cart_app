class AddProductIdToUserStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :user_statuses, :product_id, :integer
    add_foreign_key :user_statuses,:products
  end
end
