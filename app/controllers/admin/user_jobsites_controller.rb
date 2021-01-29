class Admin::UserJobsitesController < ApplicationController
    include JobsitesHelper
    layout "admin"

    def new
    end

    def create

        @jobsite = Jobsite.find(params[:user][:jobsite_id])

        user = User.find(params[:user][:id])

        if @jobsite.users.include?(user)    
            flash[:notice] = "#{user.full_name} already has access to that site." 
        else
            @jobsite.users << user
        end
        
        redirect_to edit_admin_jobsite_path(@jobsite)
    end

    def destroy
        remove = UserJobsite.find_by(jobsite_id:params[:jobsite_id], user_id:params[:id])
            remove.destroy unless remove.nil?
        redirect_to jobsite_employees_path(@jobsite)
    end
    
end