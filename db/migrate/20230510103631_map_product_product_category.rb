class MapProductProductCategory < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :product_category_with_products,:products
    add_foreign_key :product_category_with_products,:product_categories
  end
end