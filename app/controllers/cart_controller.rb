class CartController < ApplicationController
  def index
    if current_user.is? :user
      @cart_items = current_user.cart.cart_items
    else
     flash[:alert] = "You are unauthorized to access this page"
     redirect_to dashboard_index_path
    end
  end
end
