class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
  
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to admin_dashboard_index_path, alert: exception.message
  end
  private

  def after_sign_in_path_for(resource)
    if current_user.is? :admin
       admin_dashboard_index_path
    else
      products_path
    end
  end
end
