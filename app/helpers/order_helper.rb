module OrderHelper
	def is_complete(status_id, product_id)
		@status = UserStatus.where(user_id: current_user.id,status_id: status_id, product_id: product_id)
		if !@status.first.nil?
			return true
		else 
			return false
		end
	end
end
