

class CreateProductCategoryWithProduct < ActiveRecord::Migration[7.0]
  def change
    create_table :product_category_with_products do |t|
      t.integer :product_id
      t.integer :product_category_id
      t.timestamps
    end
  end
end