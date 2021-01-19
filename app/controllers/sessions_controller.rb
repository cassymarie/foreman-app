class SessionsController < ApplicationController

    def home
    end

    def new
        @user = User.new
    end

    def omniauth
        #find by provide & uid -- 
       user = User.find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |u|
            u.email = auth[:info][:email].downcase
            u.first_name = auth[:info][:first_name]
            u.last_name = auth[:info][:last_name]
            u.admin = false
            u.password = SecureRandom.hex(24)
       end

       binding.pry
       #User registered correctly
       if user.valid?
        session[:user_id] = user.id
        redirect_to user_path(user)
       else #
        flash[:message] = 'Login through Google was NOT Successful'
        redirect_to signin_path
       end


    end
    
    def create
        user = User.find_by(email: params[:user][:email].downcase)
        @user = user.try(:authenticate, params[:user][:password])
            byebug

        if @user
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            redirect_to :signin_path, notice: "Email and/or Password is Incorrect"
        end
    end

    def destroy
       # binding.pry
        session.delete :user_id
        redirect_to signin_path
    end

    private
    def auth
        request.env['omniauth.auth']
    end
end