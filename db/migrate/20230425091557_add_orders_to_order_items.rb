class AddOrdersToOrderItems < ActiveRecord::Migration[7.0]
    def change
      add_foreign_key :order_items, :orders
    end
end
