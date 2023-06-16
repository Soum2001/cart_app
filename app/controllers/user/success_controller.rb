class User::SuccessController < ApplicationController
    def index
        @total_price = 0
		@order = current_user.orders.create(invoice_number: Time.now.to_f.ceil)
        @cart_items = current_user.cart.cart_items
        @cart_items.each do |cart_item|
            
            quantity = cart_item.product.quantity #product quantity
            @total_price = @total_price + cart_item.product.price * cart_item.quantity
            @order_items = @order.order_items.create(quantity: cart_item.quantity,
                product_name: cart_item.product.name, price: cart_item.product.price)
            cart_item.product.update(quantity: quantity-cart_item.quantity)
        end
        @cart_items.delete_all
        @order.update(total_price: @total_price)
        OrderMailer.order_checkout(current_user,@order,@order_items).deliver_now
        @cart_item_quantity = CartItem.where(cart_id: current_user.cart.id).count
        @cart_items.delete_all
    end
end