class CreateOrderStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :order_statuses do |t|
      t.string :status
      t.timestamps
    end
    change_column :order_statuses, :id, :integer
  end
end
