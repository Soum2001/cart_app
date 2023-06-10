class User::PaymentController < ApplicationController
  before_action :product_exists, only:[:create_payment_intent]

  def create_payment_intent
		@cart_items = current_user.cart.cart_items
    @lineItems=[]
		@cart_items.each do |cart_item|
      if (@product_data.value?(cart_item.product.name))
        @product_id = @product_data.key(cart_item.product.name)
        @price_id = Stripe::Price.list({ product: @product_id }).data[0].id
      else
        price_amount = cart_item.product.price
        price_cents = (price_amount * 100).to_i
        # Create the product
        new_product = Stripe::Product.create({
          name: cart_item.product.name,
          type: 'service',
        })
        # Create the price and associate it with the product
        price = Stripe::Price.create({
          unit_amount: price_cents,  # Set the price in cents
          currency: 'inr',
          product: new_product.id,
        })
        @product_id = new_product.id
        @price_id = price.id
      end
      @lineItems.push(price: @price_id, quantity: cart_item.quantity)
		end
    respond_to do |format|
      format.js
    end
  end 

  private
  def product_exists
    products = Stripe::Product.list({ limit: 3 })
    @product_data = {}
    products.data.each do |product|
      @product_data[product.id] = product.name
    end
  end
end
