class Admin::JobsitesController < ApplicationController
    include JobsitesHelper
    layout "admin_sections"
    before_action :admin_required
    before_action :set_admin_jobsites

    def index
        
    end

    def new
        
    end

    def create
        @jobsite = Jobsite.create(jobsite_params)
        @jobsite.tasks << Task.new(:code => "299", :name => "General Labor")
        @jobsite.tasks << Task.new(:code => "275", :name => "Job Travel")
        render :edit
    end

    def edit
    end

    def update
        @jobsite.update(jobsite_params)
        redirect_to admin_jobsites_path
    end

    def destroy
        @jobsite.destroy
        redirect_to admin_jobsites_path
    end

   private
    def jobsite_params
        params.require(:jobsite).permit(:id, :name, :city, :state, users_attributes: [:id])
    end

    def set_admin_jobsites
        @jobsites = Jobsite.all.active
        case view_by
        when 'edit','destroy','update'
            @jobsite = Jobsite.find_by(id: params[:id])
        when 'new'
            @jobsite = Jobsite.new
        end
    end
end