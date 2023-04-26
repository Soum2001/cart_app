class ChangeUserIdName < ActiveRecord::Migration[7.0]
  def change
    rename_column :cart_items, :user_id, :cart_id
  end
end
