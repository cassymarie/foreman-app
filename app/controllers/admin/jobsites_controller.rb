class Admin::JobsitesController < ApplicationController
    include JobsitesHelper
    layout "admin_sections"
    before_action :admin_required

    def index
        @jobsites = Jobsite.all.active
    end

    def new
        @jobsite = Jobsite.new
    end

    def create
        @jobsite = Jobsite.create(jobsite_params)
        @jobsite.tasks << Task.new(:code => "299", :name => "General Labor")
        @jobsite.tasks << Task.new(:code => "275", :name => "Job Travel")
        
        render :edit
    end

    def edit
        @jobsite = Jobsite.find_by(id: params[:id])
    end

    def update
        binding.pry
        @jobsite = Jobsite.find_by(id: params[:id])
        @jobsite.update(jobsite_params)
        redirect_to jobsites_path
    end

    def delete
        @jobsite = Jobsite.find(params[:id])
    end

   private
    def jobsite_params
        params.require(:jobsite).permit(:id, :name, :city, :state, users_attributes: [:id])
    end

end