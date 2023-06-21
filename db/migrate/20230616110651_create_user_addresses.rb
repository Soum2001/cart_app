class CreateUserAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :user_addresses do |t|
      t.string :locality
      t.string :street_no
      t.string :plot_no
      t.string :district
      t.string :state
      t.string :nationality
      t.integer :pincode
      t.integer :user_id
      t.boolean :is_permanent
      t.timestamps
    end
    change_column :user_addresses, :id, :integer
    add_foreign_key :user_addresses, :users
  end
end
