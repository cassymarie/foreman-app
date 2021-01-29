class ApplicationController < ActionController::Base
    include ApplicationHelper
    
    protect_from_forgery with: :exception
    before_action :current_user

    def current_user
      @current_user = User.find_by(id: session[:user_id])
    end

    def logged_in?
      session[:user_id]
    end
  
    def authentication_required                             
      redirect_to root_path unless logged_in?
    end

    def user_jobsites
      return params[:action] == 'testing'
      jobsite =  params[:controller] == 'jobsites' ? Jobsite.find(params[:id]) : Jobsite.find(params[:jobsite_id])
      redirect_to jobsites_path unless jobsite.users.include?(@current_user) || @current_user.admin == true
    end
end
