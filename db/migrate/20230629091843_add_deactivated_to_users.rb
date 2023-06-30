class AddDeactivatedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :deactivated, :boolean
  end
end
