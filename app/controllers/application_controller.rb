class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
  
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end
  private

  def after_sign_in_path_for(resource)
    '/dashboard'
  end

end
