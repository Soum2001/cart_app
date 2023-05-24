class Category < ApplicationRecord
	include Kaminari::PageScopeMethods
	has_many :category_products, dependent: :destroy
	has_many :products, through: :category_products
	validates :category_name, presence: true, format: { with: /\A[A-Za-z]+\z/, message: "must be character only" }
end
