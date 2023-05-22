class Product < ApplicationRecord
	include Kaminari::PageScopeMethods
	validates :name,presence: true
	validates :price,presence: true
	has_many :cart_items
	has_many :order_items
	has_many :category_products
	has_many :categories, through: :category_products
end
