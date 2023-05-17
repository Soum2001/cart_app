class UserMailer < ApplicationMailer
    include Devise::Controllers::UrlHelpers
    def confirmation_instructions(user, token, opts={})
        @user = user
        @token = token
        @confirmation_url = confirmation_url(@user, confirmation_token: @token)
        mail(to: '2018ssamantaray@gmail.com', subject: 'Confirmation instructions')
      end
end
