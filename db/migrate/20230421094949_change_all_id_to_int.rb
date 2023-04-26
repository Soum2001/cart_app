class ChangeAllIdToInt < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :id, :integer
    change_column :carts, :id, :integer
    change_column :products, :id, :integer
  end
end
