class OrderItem < ApplicationRecord
	include Kaminari::PageScopeMethods
	belongs_to :order
end
