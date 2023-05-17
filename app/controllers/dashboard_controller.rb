class DashboardController < ApplicationController

    def index
      # @user = User.accessible_by(current_ability)
      if current_user.is? :admin
        authorize! :manage, :dashboard
        @user = User.all
        # Additional logic for admin dashboard
      elsif current_user.is? :user
        authorize! :read, :dashboard
        @user = current_user
      else
        sign_up_path
      end
    end
    
    def show
      # your dashboard code here
    end
  end