class AddAddressIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :user_address_id, :integer
    add_foreign_key :orders, :user_addresses, column: :user_address_id
  end
end
