class ApplicationController < ActionController::Base
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
end
