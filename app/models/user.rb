class User < ApplicationRecord
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :dob,  presence: true
  has_one :cart
  has_many :order
  after_create :create_cart

  def create_cart
    cart = Cart.create(user_id: self.id)
  end
end




