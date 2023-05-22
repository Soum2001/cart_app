class MapProductCategory < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :category_products,:products
    add_foreign_key :category_products,:categories
  end
end
