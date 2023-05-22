class UserProfileController < ApplicationController
	def create
		@user_profile = UserProfile.find_by_user_id(current_user.id)
		if @user_profile.present?
			@user_profile.phone_number = params[:phone_number]
			@user_profile.address      = params[:address]
			@user_profile.save
			redirect_to dashboard_index_path
		else
			UserProfile.create(phone_number: params[:phone_number],address: params[:address],user_id: current_user.id)
		end
	end

	def edit
		@user = UserProfile.all
	end
end
