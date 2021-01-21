class SessionsController < ApplicationController

    def new
        @user = User.new
    end

    #Google Omniauth Callback
    def omniauth

       user = User.find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |u|
            u.email = auth[:info][:email].downcase
            u.first_name = auth[:info][:first_name]
            u.last_name = auth[:info][:last_name]
            u.admin = false
            u.password = SecureRandom.hex(24)
       end

       if user.valid?
        session[:user_id] = user.id
        redirect_to jobsites_path
       else 
        flash[:message] = 'Login through Google was NOT Successful'
        redirect_to signin_path
       end
    end
    
    def create
        user = User.find_by(email: params[:user][:email].downcase)
        @user = user.try(:authenticate, params[:user][:password])

        if @user
            session[:user_id] = @user.id
            redirect_to jobsites_path
        else
            if user.nil?
                flash[:alert] = "Email and/or Password are both required to continue.."
                redirect_to signin_path
            else
                @user = user
                render :new 
            end
        end
    end

    def delete
       # binding.pry
        session.delete :user_id
        redirect_to signin_path
    end

    private
    def auth
        request.env['omniauth.auth']
    end
end