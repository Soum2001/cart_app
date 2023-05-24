class OrdersController < ApplicationController
   
	def create
		@total_price = 0
		@order = current_user.orders.create(invoice_number: Time.now.to_f.ceil)
		@cart_items = current_user.cart.cart_items
		@cart_items.each do |cart_item|
			@total_price = @total_price + cart_item.product.price * cart_item.quantity
			@order_items = @order.order_items.create(product_id: cart_item.product_id, quantity: cart_item.quantity)
		end
		@cart_items.delete_all
		@order.update(total_price: @total_price)
		OrderMailer.order_checkout(current_user,@order,@order_items).deliver_now
		flash[:notice] = "Your order has been successfully placed. Thank you for your purchase!"
		redirect_to orders_path
	end

	def index
		flash.delete(:notice)  
		redirect_to dashboard_index_path, alert: 'unauthorized' and return if  current_user.is? :admin
	end

	def show   
		order_id = params[:id]
		# @order_items = OrderItem.where(order_id: order_id)
		@order = Order.where(id: order_id).first
		# if(@order.present?)
		if @order.blank?
			flash[:now] = "Order items not present"
			redirect_to orders_path and return
		end
		@order_items = @order.order_items.eager_load(:product)	
	end
end
