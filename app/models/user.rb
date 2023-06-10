class User < ApplicationRecord
  include Kaminari::PageScopeMethods
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :first_name, presence: true, format: { with: /\A[A-Za-z]+\z/, message: "should only contain alphabetic characters" }
  validates :last_name, presence: true, format: { with: /\A[A-Za-z]+\z/, message: "should only contain alphabetic characters" }
  validates :dob,  presence: true
  validate :date_of_birth_in_the_past
  validates :email, format: { with: /\A[a-z0-9а-я_.-]{4,20}@[a-zа-я_]{2,5}\.[a-zа-я]{2,5}(\.[a-zа-я]{2,5})?\z/i, message: "is not a valid email address" }
  has_one :cart, dependent: :destroy 
  has_many :orders, dependent: :destroy 
  has_many :products, dependent: :destroy 
  has_many :user_roles
  has_many :roles, through: :user_roles, dependent: :destroy
  has_one  :user_profile, dependent: :destroy 
  pay_customer string_attributes: :stripe_attribute
  after_create :create_cart, 
 

  def create_cart
    cart = Cart.create(user_id: self.id)
  end

  # def send_confirmation_instructions
  #   UserMailer.confirmation_instructions(self, confirmation_token).deliver
  # end
  def date_of_birth_in_the_past
    errors.add(:dob, "must be in the past") if dob.present? && dob > Date.today
  end
  
  def is?( requested_role )
    self.roles.first.role == requested_role.to_s
  end

# app/models/user.rb



  def stripe_attribute
    {
      address: {
        city: pay_customer.owner.city,
        country: pay_customer.owner.country
      },
      metadata: {
        pay_customer_id: pay_customer.id,
        user_id: id
      }
    }
  end



  
end




