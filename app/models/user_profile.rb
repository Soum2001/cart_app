class UserProfile < ApplicationRecord
	belongs_to  :user
	validates :address, presence: true, format: { with: /\A[\w\s\-,.'#]+\z/, message: "must be character" }
	validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: "should be 10 digits" }
end

