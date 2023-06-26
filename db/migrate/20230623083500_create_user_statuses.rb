class CreateUserStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :user_statuses do |t|
      t.integer :user_id
      t.integer :status_id
      t.timestamps
    end
  end
end
