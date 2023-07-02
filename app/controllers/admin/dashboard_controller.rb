class Admin::DashboardController < ApplicationController
	before_action :select_all_user, only:[:index, :destroy] 

	def index
		if current_user.nil?
			redirect_to new_user_session_path
		else
			if current_user.is? :admin
				authorize! :manage, :dashboard
				authorize! :access, :admin
				
				# Additional logic for admin dashboard
			elsif current_user.is? :user
				authorize! :read, :dashboard
				@user = current_user
				flash[:alert] = "you are unauthorized to access this page"
				redirect_to products_path
			else
				sign_up_path
			end
		end
	end

	def show
		# view customer profile
		@user = User.find(params[:id])
		session[:user_id] = @user.id 
		@address = UserAddress.where(user_id: @user.id)
		render 'user/profiles/index'
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to admin_dashboard_index_path
	end

	private
	def select_all_user
		role_id = Role.where(role: "user").first.id
		@users = User.joins(:user_roles).where(user_roles: {role_id: role_id})
	end
end
