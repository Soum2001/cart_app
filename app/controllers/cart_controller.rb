class CartController < ApplicationController
  def index
    if current_user.is? :user
      authorize! :read, :dashboard
      @cart_items = current_user.cart.cart_items
    else
     redirect_to dashboard_index_path
    end
  end
end
