class JobsitesController < ApplicationController
    include ApplicationHelper
    
    before_action :authentication_required
    before_action :user_jobsites, except: [:index, :new]
    before_action :current_jobsite
    layout "application" #, only: [:index]
    #layout "jobsite", only: [:show]

    def index
       @jobsites = @current_user.admin == true ? Jobsite.all.active : @current_user.jobsites
       if @jobsites.size == 1
            redirect_to jobsite_path(@jobsites[0])
       end
    end

    def new
        @jobsite = Jobsite.new
    end
    
    def testing
    end

    def show
        @jobsites = @current_user.admin == true ? Jobsite.all.active : @current_user.jobsites
    end

    def edit
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