class SessionsController < Devise::SessionsController
  def create
    super do |user| 
      if (Time.current - user.last_sign_in_at) >= 2.days
        user.update(deactivated: 1)
      else
        user.update(deactivated: 0)
      end
    end
  end
end
  