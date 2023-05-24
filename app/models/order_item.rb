class OrderItem < ApplicationRecord
	include Kaminari::PageScopeMethods
	belongs_to :product
	belongs_to :order
end
