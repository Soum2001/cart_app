class DashboardController < ApplicationController
  before_action :select_all_user, only:[:index, :destroy] 

  def index
    # @user = User.accessible_by(current_ability)
    if current_user.is? :admin
      authorize! :manage, :dashboard
      authorize! :access, :admin
      # Additional logic for admin dashboard
    elsif current_user.is? :user
      authorize! :read, :dashboard
      @user = current_user
    else
      sign_up_path
    end
  end

  def show
    # view customer profile
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render partial: 'table'
  end

  private
  def select_all_user
    @users = User.joins(:user_roles).where(user_roles: {role_id: 2})
  end
end