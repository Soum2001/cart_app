class ProductCategory < ApplicationRecord
    include Kaminari::PageScopeMethods
    has_many :product_category_with_products
    has_many :products, through: :product_category_with_products
   
end
