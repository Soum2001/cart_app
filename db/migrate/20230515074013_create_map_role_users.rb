class CreateMapRoleUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :map_role_users do |t|
      t.integer :role_id
      t.integer :user_id
      t.timestamps
    end
  end
end
