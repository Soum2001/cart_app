class SendMailJob < ApplicationJob
  queue_as :default

  def perform(user, order, order_items)
    # Do something later
    OrderMailer.order_checkout(user, order, order_items).deliver
  end
end
