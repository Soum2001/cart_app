class AddFkRole < ActiveRecord::Migration[7.0]
  def change
    change_column :roles, :id, :integer
    add_foreign_key :map_role_users,:roles
    add_foreign_key :map_role_users,:users
  end
end
