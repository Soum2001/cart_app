class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

    def create
        email = params[:user][:email]
        password = params[:user][:password]
        password_confirmation = params[:user][:password_confirmation]
        # Check duplicate email
        existing_user = User.find_by(email: email)
        if existing_user  
            flash[:alert] = 'Email already exists'
            redirect_to new_user_registration_path
        else  
            if password == password_confirmation
                # Password confirmation matched
                user = User.new(sign_up_params)  
                if user.save
                    user_role = MapRoleUser.new(role_id: params[:user][:role], user_id: user.id)
                    if user_role.save
                        flash[:notice] = 'Go to mail and confirm your account'
                        user.send_confirmation_instructions
                        redirect_to new_user_registration_path
                    else
                        flash[:alert] = 'Failed to create user'
                        redirect_to new_user_registration_path
                    end
                else
                flash[:alert] = 'Failed to create user'
                redirect_to new_user_registration_path
                end
            else
                # Password confirmation does not match
                flash[:alert] = 'Password confirmation does not match '
                redirect_to new_user_registration_path
            end
        end
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :email,:last_name, :dob, :password, :password_confirmation, :confirmable])
    end

    private
    def sign_up_params
      params.require(:user).permit(:email, :first_name, :last_name, :dob, :password, :password_confirmation)
    end
  end