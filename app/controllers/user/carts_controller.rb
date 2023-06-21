class User::CartsController < ApplicationController
  def index
    if current_user.is? :user
      @cart_items = current_user.cart.cart_items
      @address = UserAddress.where(user_id: current_user.id)
    else
     flash[:alert] = "You are unauthorized to access this page"
     redirect_to admin_dashboard_index_path
    end
  end
end
