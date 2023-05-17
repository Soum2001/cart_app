class RemoveColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :roles, :role_id_id 
  end
end
