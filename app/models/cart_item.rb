class CartItem < ApplicationRecord
	belongs_to :cart
	belongs_to :product

	def set_quantity params
		if(params[:quantity]=="increment")
      self.quantity =  self.quantity+1
    else
      self.quantity =  self.quantity-1
      if self.quantity == 0
        self.delete
      end
    end
    self.save
	end
end
