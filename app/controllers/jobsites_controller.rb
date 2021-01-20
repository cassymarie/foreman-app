class JobsitesController < ApplicationController
    before_action :authentication_required
    before_action :set_jobsite, only: [:show, :edit]
    before_action :user_jobsites, except: [:index, :new]

    def index
       @jobsites = @current_user.jobsites
    end
    # get '/jobsites' do
    #     redirect '/error' if !logged_in? 
    #     #@jobsites = current_user.jobsites
    #     erb :'jobsites/index', :layout => :'layouts/layout_jobsite'
    # end

    def new
        @jobsite = Jobsite.new
    end
    # get '/jobsites/new' do
    #     redirect '/error' if !logged_in? 
    #     #@jobsites = current_user.jobsites
    #     erb :'jobsites/new', :layout => :'layouts/layout_jobsite'
    # end
    
    def show
        #@jobsite = Jobsite.find_by(id: params[:id])        
    end
    # get '/jobsite/:id' do 
    #     redirect '/error' if !logged_in?
    #     @jobsite = Jobsite.find(params[:id])
    #     redirect '/jobsites' unless @jobsite.users.include?(current_user)
    #     erb :'jobsites/show', :layout => :'layouts/layout_jobsite'
    # end

    def edit
        #@jobsite = Jobsite.find_by(id: params[:id])
    end
    # get '/jobsite/edit/:id' do
    #     redirect '/error' if !logged_in? 
    #     #@jobsites = current_user.jobsites
        
    #     erb :'jobsites/edit', :layout => :'layouts/layout_jobsite'
    # end

    def create
        jobsite = Jobsite.create(jobsite_params)
        jobsite.tasks << Task.new(:code => "299", :name => "General Labor")
        jobsite.tasks << Task.new(:code => "275", :name => "Job Travel")
        @current_user.jobsites << jobsite
        redirect_to jobsites_path
    end
    # post '/jobsite/new' do
    #     jobsite = Jobsite.create(params[:jobsite])
    #     jobsite.tasks << Task.new(:code => "299", :name => "General Labor")
    #     jobsite.tasks << Task.new(:code => "275", :name => "Job Travel")
    #     current_user.jobsites << jobsite
    #     redirect '/jobsites'
    # end

    def update
        @jobsite = Jobsite.find_by(id: param[:id])
        @jobsite.update(jobsite_params)
        redirect_to jobsites_path
    end
    # patch '/jobsite/edit/:id' do
    #     jobsite = Jobsite.find(params[:id])
    #     jobsite.name = params[:jobsite][:name]
    #     jobsite.save
    #     redirect '/jobsites'
    # end

    def delete
        @jobsite = Jobsite.find(params[:id])
    end
    # delete '/jobsite/delete/:id' do
    #     jobsite = Jobsite.find(params[:id])
    #     jobsite.delete
    #     redirect '/jobsites'
    # end

   private
    def jobsite_params
        params.require(:jobsite).permit(:id, :name)
    end

    def set_jobsite
        @jobsite = Jobsite.find_by(id: params[:id]) 
    end

    def user_jobsites
        redirect_to jobsites_path unless @jobsite.users.include?(@current_user)
    end
end