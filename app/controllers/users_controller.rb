class UsersController < ApplicationController
    include SessionsHelper
    layout "login"
    before_action :authentication_required, only: [:show]
    skip_before_action :verify_authenticity_token

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        @user.email.downcase!
        @user.provider = 'email'

        if @user.save 
            session[:user_id] = @user.id
            redirect_to jobsites_path
        else
            alert = ''
            @user.errors.full_messages.each {|err| alert += "#{flash[:alert] = err}... "} unless @user.errors.nil?
            flash[:alert] = alert
            render new_user_path
        end
    end

    def destroy
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :admin, :password, :uid, :provider)
    end

  end
