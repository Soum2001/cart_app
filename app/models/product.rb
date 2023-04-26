class Product < ApplicationRecord
    include Kaminari::PageScopeMethods
    validates :name,presence: true
    validates :price,presence: true
    has_many :cart_items
    has_many :order_items
end
