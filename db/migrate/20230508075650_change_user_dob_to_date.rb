class ChangeUserDobToDate < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :dob, :datetime
  end
end
