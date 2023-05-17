class User < ApplicationRecord
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :dob,  presence: true
  validates :email, uniqueness: true
  has_one :cart
  has_many :orders
  has_many :map_role_users
  has_many :roles, through: :map_role_users
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

  protected
  def confirmation_required?
    false
  end
end




