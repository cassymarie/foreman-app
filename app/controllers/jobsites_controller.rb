class JobsitesController < ApplicationController
    
    get '/jobsites' do
        redirect '/error' if !logged_in? 
        #@jobsites = current_user.jobsites
        erb :'jobsites/index', :layout => :'layouts/layout_jobsite'
    end

    get '/jobsites/new' do
        redirect '/error' if !logged_in? 
        #@jobsites = current_user.jobsites
        erb :'jobsites/new', :layout => :'layouts/layout_jobsite'
    end

    get '/jobsite/edit/:id' do
        redirect '/error' if !logged_in? 
        #@jobsites = current_user.jobsites
        @jobsite = Jobsite.find(params[:id])
        erb :'jobsites/edit', :layout => :'layouts/layout_jobsite'
    end

    get '/jobsite/delete/:id' do
        redirect '/error' if !logged_in? 
        #@jobsites = current_user.jobsites
        @jobsite = Jobsite.find(params[:id])
        erb :'jobsites/delete', :layout => :'layouts/layout_jobsite'
    end

    get '/jobsite/:id' do 
        redirect '/error' if !logged_in?
        @jobsite = Jobsite.find(params[:id])
        redirect '/jobsites' unless @jobsite.users.include?(current_user)
        erb :'jobsites/show', :layout => :'layouts/layout_jobsite'
    end

    post '/jobsite/new' do
        jobsite = Jobsite.create(params[:jobsite])
        jobsite.tasks << Task.new(:code => "299", :name => "General Labor")
        jobsite.tasks << Task.new(:code => "275", :name => "Job Travel")
        current_user.jobsites << jobsite
        redirect '/jobsites'
    end

    patch '/jobsite/edit/:id' do
        jobsite = Jobsite.find(params[:id])
        jobsite.name = params[:jobsite][:name]
        jobsite.save
        redirect '/jobsites'
    end

    delete '/jobsite/delete/:id' do
        jobsite = Jobsite.find(params[:id])
        jobsite.delete
        redirect '/jobsites'
    end

end