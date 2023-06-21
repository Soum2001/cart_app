class OrderMailer < ApplicationMailer
    default from: "2018ssamantaray@zohomail.in"
    def order_checkout(current_user,order,order_items)
        @current_user = current_user
        @order        = order
        @order_items  = order_items
        attachments["order_#{@order.id}.pdf"] = File.read("public/order_#{@order.id}.pdf")
        mail(to: '2018ssamantaray@gmail.com', subject: 'Welcome to My Awesome Site')
    end
end
