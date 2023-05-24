class AddUserId < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :user_id, :integer
    add_foreign_key :products,:users
  end
end
