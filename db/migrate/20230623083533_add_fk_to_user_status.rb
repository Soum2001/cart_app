class AddFkToUserStatus < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :user_statuses,:users
    add_foreign_key :user_statuses,:order_statuses, column: :status_id
  end
end
