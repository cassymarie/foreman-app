class UsersController < ApplicationController
    before_action :authentication_required, only: [:show]

    def new
        @user = User.new
        #binding.pry
    end

    # def show
    #     @user = User.find(params[:id])
    #     @jobsites = @user.jobsites
    # end

    def create
        @user = User.new(user_params)
        @user.email.downcase!
        @user.provider = 'email'

        if @user.save 
            session[:user_id] = @user.id
            redirect_to jobsites_path
        else
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

# class UserController < ApplicationController

#     #View Main Sign-Up Page
#     get '/signup' do
#         erb :'users/new', :layout => :'layouts/layout_signin'
#     end

#     get '/error' do
#         erb :error, :layout => :'layouts/layout_signin'
#     end

#     #Create a new user (if valid)
#     post '/signup' do
#         @user = User.new(params[:user])
#         if @user.save
#             session[:user_id] = @user.id
#             redirect to '/jobsites'
#         else
#             @error = @user.errors.full_messages.join(" - ")
#             erb :'users/new', :layout => :'layouts/layout_signin'
#         end
#     end

# end
