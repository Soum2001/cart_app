class User::OrdersController < ApplicationController
   
	def create
		@total_price = 0
		@order = current_user.orders.create(invoice_number: Time.now.to_f.ceil)
		@cart_items = current_user.cart.cart_items
		@cart_items.each do |cart_item|
			@total_price = @total_price + cart_item.product.price * cart_item.quantity
			@order_items = @order.order_items.create(quantity: cart_item.quantity,
				product_name: cart_item.product.name, price: cart_item.product.price)
		end
		@cart_items.delete_all
		@order.update(total_price: @total_price)
		OrderMailer.order_checkout(current_user,@order,@order_items).deliver_now
		flash[:notice] = "Your order has been successfully placed. Thank you for your purchase!"
		redirect_to user_orders_path
	end

	def index 
		@orders = Order.page(params[:page]).per(10).where(user_id: current_user.id)
		redirect_to admin_dashboard_index_path, alert: 'you are unauthorized to access this page' and return if  current_user.is? :admin
	end

	def show   
		order_id = params[:id]
		# @order_items = OrderItem.where(order_id: order_id)
		@order = Order.where(id: order_id).first
		# if(@order.present?)
		if @order.blank?
			flash[:now] = "Order items not present"
			redirect_to user_orders_path and return
		end
		@order_items = @order.order_items	
	end
	
end
