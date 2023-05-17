class Product < ApplicationRecord
    include Kaminari::PageScopeMethods
    validates :name,presence: true
    validates :price,presence: true
    has_many :cart_items
    has_many :order_items
    has_many :product_category_with_products
    has_many :category, through: :product_category_with_products
end
