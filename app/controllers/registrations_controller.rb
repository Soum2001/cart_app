class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def create
    email = params[:user][:email]
    password = params[:user][:password]
    password_confirmation = params[:user][:password_confirmation]
    redirect_to new_user_registration_path, alert: 'Email already exists' and return if User.exists?(email: email)
    redirect_to new_user_registration_path, alert: 'Password confirmation does not match' and return if  password != password_confirmation
    super do |resource|
      if resource.valid?
        # Add role to user
        role = Role.where(role: "user").first.id
        #resource.roles << role
        resource.user_roles.create(role_id: role_id)
        UserRole.create(user_id: resource.id, role_id: role_id)
        if params[:check] == "checked"
          role_id = Role.where(role: "seller").first.id
          resource.user_roles.create(role_id: role_id)
        end
        UserProfile.create(address: "NA",phone_number: "1234567890", user_id: resource.id)
        flash[:notice] = 'Go to mail and confirm your account'
        resource.send_confirmation_instructions if resource.persisted?
        redirect_to new_user_registration_path and return
      else
        flash[:alert] = resource.errors.full_messages.to_s
        redirect_to new_user_registration_path and return
      end
    end
  end

  protected
  def after_sign_up_path_for(resource)
    # Add your custom logic here
    # For example, you can redirect to a different page or render a specific view
    new_user_registration_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :email,:last_name, :dob, :password, :password_confirmation, :confirmable])
  end
  

  private
  def sign_up_params
    params.require(:user).permit(:email, :first_name, :last_name, :dob, :password, :password_confirmation)
  end
  
  end