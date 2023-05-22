class OrdersController < ApplicationController
   
	def create
		@total_price = 0
		@order = current_user.orders.create(invoice_number: Time.now.to_f.ceil)
		current_user.cart.cart_items.each do |cart_item|
			@total_price = @total_price + cart_item.product.price * cart_item.quantity
			@order_items = @order.order_items.create(product_id: cart_item.product_id, quantity: cart_item.quantity)
			cart_item.destroy
		end
		@order.update(total_price: @total_price)
		OrderMailer.order_checkout(current_user,@order,@order_items).deliver_now
		redirect_to orders_path
		# cart_items   = current_user.cart.cart_items.pluck(:product_id,:quantity)
		# total_price  = cart_items.sum{|item| Product.find(item[0]).price*item[1]}
		# product      = Hash[cart_items]
		
		# @order = current_user.order.create(invoice_number: Time.now.to_f.ceil, total_price: total_price)
		# product.each do |product_id,quantity|
		#     order_items = @order.order_items.create(product_id: product_id, quantity: quantity)
		# end
		# @del_cart_item = current_user.cart.cart_items.destroy_all
		# redirect_to orders_path
		# if(Order.find_by(user_id: current_user.id))
				# @total_price = 0
				# @product = {}
				# current_user.cart.cart_items.map do |i|
				#     @total_price += i.product.price*i.quantity
				#     @product[i.product.id] = i.quantity
				# end  
				# @order = Order.create(invoice_number:  Time.now.to_f.ceil, total_price: @total_price, user_id: current_user.id)
				# @order_id = @order.id
				# @product.each do |k,v|
				#     @order_items = OrderItem.create(order_id: @order_id, product_id: k, quantity: v)
				# end
				# @del_cart_item = current_user.cart.cart_items.destroy_all
				# redirect_to orders_path
		# else
		#     flash[:notice] = "This Order is already existing"
		#     redirect_to cart_path
		# end
	end

	def index
		flash.delete(:notice)  
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
