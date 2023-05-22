class CartController < ApplicationController
  def index
    @cart_items = current_user.cart.cart_items
  end
end
