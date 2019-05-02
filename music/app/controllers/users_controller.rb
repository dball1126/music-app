class UsersController < ApplicationController
    before_action :ensured_logged_in?, except: [:create, :new]

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in_user!(@user)
            redirect_to bands_url
        else
            flash.now[:errors] = ["Incorrect paramters"]
            render :new
            
        end
    end

    def main

    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end