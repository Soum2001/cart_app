class User::AddressController < ApplicationController
    def new
        @address = UserAddress.new
        respond_to do |format|
            format.js
          end
    end
    def create
        @address = UserAddress.new(locality: params[:user_address][:locality], street_no: params[:user_address][:street_no],
            plot_no: params[:user_address][:plot_no], district: params[:user_address][:district],
            state: params[:user_address][:state], nationality: params[:user_address][:nationality],
            pincode: params[:user_address][:pincode], user_id: current_user.id) 
        if(@address.save)
            flash[:message] = "Address added successfully"
            redirect_to user_profiles_path
        end
    end

    def update
        @address = UserAddress.where(user_id: current_user.id)
        @address.update(is_permanent: 0)
        @address.where(id: params[:id]).update(is_permanent: 1)
        @id = params[:id]
        respond_to do |format|
            format.js
         end
    end

    
end