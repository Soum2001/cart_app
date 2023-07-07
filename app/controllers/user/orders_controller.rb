class User::OrdersController < ApplicationController
	include OrderHelper
	# def create
	# 	@total_price = 0
	# 	@order = current_user.orders.create(invoice_number: Time.now.to_f.ceil)
	# 	@cart_items = current_user.cart.cart_items
	# 	@cart_items.each do |cart_item|
	# 		@total_price = @total_price + cart_item.product.price * cart_item.quantity
	# 		@order_items = @order.order_items.create(quantity: cart_item.quantity,
	# 			product_name: cart_item.product.name, price: cart_item.product.price)
	# 	end
	# 	@cart_items.delete_all
	# 	@order.update(total_price: @total_price)
	# 	OrderMailer.order_checkout(current_user,@order,@order_items).deliver_now
	# 	flash[:notice] = "Your order has been successfully placed. Thank you for your purchase!"
	# 	redirect_to user_orders_path
	# end

	def index 
		@orders = Order.page(params[:page]).per(10).where(user_id: current_user.id)
		@role = current_user.roles.find_by_role("seller") 
		redirect_to admin_dashboard_index_path, alert: 'you are unauthorized to access this page' and return if  current_user.is? :admin
	end

	def show   
		order_id = params[:id]
		# @order_items = OrderItem.where(order_id: order_id)
		@order = Order.find_by(id: order_id,user_id: current_user.id)
		# if(@order.present?)
		# if @order.blank?
		# 	flash[:now] = "Order items not present"
		# 	redirect_to user_orders_path and return
		# end
		if(@order.present?)
			@order_items = @order.order_items
		else
			flash[:alert] = "you are unauthorized to access this page"
			redirect_to admin_dashboard_index_path and return
		end	
	end

	# To view user's order details in seller page
	def user_order_details
		@product = current_user.products.pluck("id")
		#@order_id = OrderItem.where(product_id: @product).pluck("order_id")
		# @user = User.joins(:orders).where(orders:{id: @order_id})
		@user_order_details = User.joins(orders: :order_items).joins(:user_addresses)
		.where(order_items:{product_id: @product})
		.select('order_items.product_name','order_items.quantity','order_items.product_id',
			'order_items.price','users.id','users.first_name',
			'users.last_name','user_addresses.locality',
			'user_addresses.street_no','user_addresses.plot_no',
			'user_addresses.district','user_addresses.state',
			'user_addresses.nationality','user_addresses.pincode')
	end

	def order_status
		status_id = OrderStatus.statuses.key(params[:status])
		@order_status = UserStatus.where(user_id: params[:user_id]).where(product_id: params[:product_id])
		if ( @order_status.first.nil?)
			@track_data = UserStatus.create(user_id: params[:user_id], status_id: status_id, product_id: params[:product_id])
		else
			@track_data = UserStatus.where(user_id: params[:user_id], product_id: params[:product_id]).update(status_id: status_id)
		end
		OrderMailer.track_details(@track_data,params[:user_id]).deliver_now
		# i = 0
		# @status = []
		# while i<= status_id
		# 	@status << OrderStatus.statuses[i]
		# 	i=i+1
		# end
		# respond_to do |format|
		# 	format.js
		# end
	end
	
end
