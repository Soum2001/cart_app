class ProductCategoryWithProduct < ApplicationRecord
    
    include Kaminari::PageScopeMethods
    belongs_to :product
    belongs_to :product_category
end
