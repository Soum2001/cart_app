class CreateUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles do |t|
      t.string  :phone_number
      t.string  :address
      t.integer :user_id
      t.timestamps
    end
    change_column :user_profiles, :id, :integer
    add_foreign_key :user_profiles, :users
  end
end
