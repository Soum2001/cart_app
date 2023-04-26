class RegistrationsController < Devise::RegistrationsController
    private
    def sign_up_params
      params.require(:user).permit(:email, :first_name, :last_name, :dob, :password, :password_confirmation)
    end
  end