class Admin::JobsitesController < ApplicationController
    include JobsitesHelper
    layout "admin"
    before_action :admin_required
    before_action :set_admin_variables

    def new
        @jobsite = Jobsite.new
    end

    def create
        jobsite = Jobsite.create(jobsite_params)
        jobsite.tasks << Task.new(:code => "299", :name => "General Labor")
        jobsite.tasks << Task.new(:code => "275", :name => "Job Travel")
        @current_user.jobsites << jobsite
        redirect_to jobsites_path
    end

    def update
        @jobsite = Jobsite.find_by(id: param[:id])
        @jobsite.update(jobsite_params)
        redirect_to jobsites_path
    end

    def delete
        @jobsite = Jobsite.find(params[:id])
    end

   private
    def jobsite_params
        params.require(:jobsite).permit(:id, :name, :city, :state)
    end

end