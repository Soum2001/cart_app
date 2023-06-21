class User::SuccessController < ApplicationController
	
	def index
		@total_price = 0
		@address_id = UserAddress.where(is_permanent: 1,user_id: current_user.id)
	@order = current_user.orders.create(invoice_number: Time.now.to_f.ceil, user_address_id: @address_id[0].id)
	@cart_items = current_user.cart.cart_items
	products = [['Sl.No','Product', 'Quantity','Price']]
	i = 0
	@cart_items.each do |cart_item|
		array = []
		quantity = cart_item.product.quantity #product quantity
		@total_price = @total_price + cart_item.product.price * cart_item.quantity
		@order_items = @order.order_items.create(quantity: cart_item.quantity,
				product_name: cart_item.product.name, price: cart_item.product.price)
		cart_item.product.update(quantity: quantity-cart_item.quantity)
		array << i+1
		array << cart_item.product.name
		array << cart_item.quantity
		array << "#{cart_item.product.price}/-"
		products << array 
	end
	products << ["","","Total","#{@total_price}/-"]
	@order.update(total_price: @total_price)
	pdf = Prawn::Document.new
		pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width / 2) do
			pdf.text "Hi #{current_user.first_name}", align: :left, size: 10
			pdf.move_down 5
			pdf.text "Thanks for purchasing from Ekart", size: 9
		end
		pdf.move_up 20
	  pdf.bounding_box([pdf.bounds.width / 2, pdf.cursor], width: pdf.bounds.width / 2) do
			pdf.draw_text "shipped to",at: [80, pdf.cursor]
			address_data = [
				["plot no:", "#{@address_id[0].plot_no}"],
				["street no:", "#{@address_id[0].street_no}"],
				["locality:", "#{@address_id[0].locality}"],
				["district:", "#{@address_id[0].district}"],
				["state:", "#{@address_id[0].state}"],
				["nationality:", "#{@address_id[0].nationality}"],
				["pincode:", "#{@address_id[0].pincode}"]
			]
			cell_width = pdf.bounds.width / 2 - 30 # Adjust the width of the individual cells
			pdf.table address_data, cell_style: { border_width: 0, width: cell_width, padding: [2, 0, 2, 0], inline_format: true, align: :center, size: 9 }
	end
	pdf.move_down 30
	pdf.text "Your purchased order is listed below", size: 9
	pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width) do
		order_data = products
		cell_width = pdf.bounds.width / 2 - 200 # Adjust the width of the individual cells
		pdf.table order_data, cell_style: { border_width: 0, width: cell_width, padding: [3, 0, 3, 0], inline_format: true, align: :center, size: 10,float: :left }
	end
	pdf.move_down 50
	pdf.text " Thank You"
	pdf.render_file(Rails.root.join('public', "order_#{@order.id}.pdf"))	
	OrderMailer.order_checkout(current_user,@order,@order_items).deliver_now
	@cart_item_quantity = CartItem.where(cart_id: current_user.cart.id).count
	@cart_items.delete_all
	end
end