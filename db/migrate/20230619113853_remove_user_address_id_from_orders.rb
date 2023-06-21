class RemoveUserAddressIdFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :user_address_id
  end
end
