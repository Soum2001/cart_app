
class ChangeProductCategoryIdToInt < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :id, :integer
    change_column :product_categories, :id, :integer
  end
end