class SessionsController < Devise::SessionsController
    # def create 
    #     super
    #     @user = User.where(email: params[:user][:email]).first
    #     if @user.present?
    #         if @user.confirmed?
    #             super
    #             flash[:alert] = "Enter valid password"
    #         end
    #     else
    #         flash[:alert] = "There is no account in this mail"
    #         redirect_to new_user_session_url
    #     end
    # end
end
