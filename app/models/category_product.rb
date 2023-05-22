class CategoryProduct < ApplicationRecord
	include Kaminari::PageScopeMethods
	belongs_to :product
	belongs_to :category
end
