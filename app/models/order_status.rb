class OrderStatus < ApplicationRecord
    enum :status, { 0 => "pending", 1 => "confirmed", 2 => "shipped",3=> "delivered", 4 => "cancelled" }
end