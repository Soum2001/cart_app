class ChangeOrderIdToInt < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :id, :integer
  end
end
