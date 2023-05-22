class Category < ApplicationRecord
	include Kaminari::PageScopeMethods
	has_many :category_products
	has_many :products, through: :category_products
end
