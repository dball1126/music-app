class SessionsController < ApplicationController
    before_action :ensured_logged_in?, except: [:new, :create]


    def new
        render :new
    end

    def create
        user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        unless user.nil? 
            log_in_user!(user)
            redirect_to bands_url
        else
            flash.now[:errors] = ["Invalid Credentials"]
            render :new
        end

    end


    def destroy
        logout!
        redirect_to new_session_url
    end


end