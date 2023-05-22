class ChangeCategoryId < ActiveRecord::Migration[7.0]
  def change
    change_column :categories, :id, :integer
    change_column :category_products, :id, :integer
  end
end
