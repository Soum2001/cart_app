class OrdersController < ApplicationController
    def create
        # if(Order.find_by(user_id: current_user.id))
            @total_price = 0
            @product = {}
            current_user.cart.cart_items.map do |i|
                @total_price += i.product.price*i.quantity
                @product[i.product.id] = i.quantity
            end  
            @order = Order.create(invoice_number:  Time.now.to_f.ceil, total_price: @total_price, user_id: current_user.id)
            @order_id = @order.id
            @product.each do |k,v|
                @order_items = OrderItem.create(order_id: @order_id, product_id: k, quantity: v)
            end
            @del_cart_item = current_user.cart.cart_items.destroy_all
            redirect_to orders_path
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
    
        if !@order.present?
            flash[:now] = "Order items not present"
            redirect_to orders_path
        end
        
    end
end
