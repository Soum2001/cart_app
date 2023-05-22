class User < ApplicationRecord
  include Kaminari::PageScopeMethods
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :first_name, presence: true, format: { with: /\A[A-Za-z]+\z/, message: "should only contain alphabetic characters" }
  validates :last_name, presence: true, format: { with: /\A[A-Za-z]+\z/, message: "should only contain alphabetic characters" }
  validates :dob,  presence: true
  validates :email, uniqueness: true
  has_one :cart, dependent: :destroy 
  has_many :orders, dependent: :destroy 
  has_many :user_roles
  has_many :roles, through: :user_roles, dependent: :destroy
  has_one  :user_profile
  after_create :create_cart, 

  def create_cart
    cart = Cart.create(user_id: self.id)
  end

  # def send_confirmation_instructions
  #   UserMailer.confirmation_instructions(self, confirmation_token).deliver
  # end
  
  def is?( requested_role )
    self.roles.first.role == requested_role.to_s
  end


end




