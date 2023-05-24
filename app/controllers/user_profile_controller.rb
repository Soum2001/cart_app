class UserProfileController < ApplicationController
	before_action :user_params, only:[:update]

	def index
		if current_user.is? :admin
			authorize! :manage, :dashboard
			@user = User.find(session[:user_id])
		else
			authorize! :read, :dashboard
			@user = current_user
		end
	end
	def edit
		@user = UserProfile.find_by_user_id(params[:id])
	end

	def update
    @user_profile = UserProfile.find(params[:id])
			if @user_profile.update(user_params)
				@user = current_user
				flash[:success] = "Edited successfully"
				render 'index'
			else
				@user = current_user.user_profile
				flash[:alert] = @user_profile.errors.full_messages
      	render 'edit'
    	end
	end

	private

	def user_params
		params.require(:user_profile).permit(:address, :phone_number)
	end

end
