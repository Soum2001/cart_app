class MapRoleToUser < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :user_roles,:users
  end
end
