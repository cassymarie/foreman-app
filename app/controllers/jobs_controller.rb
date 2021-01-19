class JobsController < ApplicationController

    get '/abc-jobs' do
        @jobs = Job.where(:customer => "ABC Company LLC")
        erb :'jobs/customer'
    end

    get '/jobsite/:id/jobs/new' do
        redirect '/error' if !logged_in?
        @jobsite = Jobsite.find(params[:id])
        redirect '/jobsites' unless @jobsite.users.include?(current_user)
        erb :'jobs/new', :layout => :'layouts/layout_jobs'
    end

    get '/jobsite/:id/jobs/edit/:job_id' do
        redirect '/error' if !logged_in?
        @jobsite = Jobsite.find(params[:id])
        redirect '/jobsites' unless @jobsite.users.include?(current_user)
        @job = Job.find(params[:job_id])
        erb :'jobs/edit', :layout => :'layouts/layout_jobs'
    end

    get '/jobsite/:id/jobs/edit' do
        redirect '/error' if !logged_in?
        @jobsite = Jobsite.find(params[:id])
        redirect '/jobsites' unless @jobsite.users.include?(current_user)

        if @jobsite.jobs.size == 0 
            redirect "/jobsite/#{@jobsite.id}/jobs/new"
        else
            erb :'jobs/edit', :layout => :'layouts/layout_jobs'
        end
    end

    get '/jobsite/:id/jobs/delete/:job_id' do
        redirect '/error' if !logged_in?
        @jobsite = Jobsite.find(params[:id])
        redirect '/jobsites' unless @jobsite.users.include?(current_user)

        @job = Job.find(params[:job_id])
        erb :'jobs/delete', :layout => :'layouts/layout_jobs'
    end

    post '/jobsite/:id/jobs/new/area' do
        @job = Job.find(params[:job_id].to_i)
        new_area = Area.create(:code => params[:area][:code].upcase, :name => params[:area][:name].capitalize)
        @job.areas << new_area
        @jobsite = Jobsite.find(params[:id])
        new_area.name = params[:area][:name].capitalize
        new_area.save
        redirect "/jobsite/#{@jobsite.id}/jobs/edit/#{@job.id}"
        # erb :'jobs/edit', :layout => :'layouts/layout_jobs'
    end

    post '/jobsite/:id/jobs/new' do
        @jobsite = Jobsite.find(params[:id])
        job = Job.create(params[:job])
        @jobsite.jobs << job
        areas = params[:areas]
        areas.each do |a|
            area = Area.find(a.to_i)
            job.areas << area
        end
        job.save
        redirect "jobsite/#{@jobsite.id}/jobs/new"
    end

    patch '/jobsite/:id/jobs/edit/:job_id' do
        job = Job.find(params[:job_id].to_i)
        job.update(params[:job])
        areas = params[:areas]
            job.areas.clear
            areas.each do |a|
                area = Area.find(a.to_i)
                job.areas << area
            end
        job.save
        redirect "jobsite/#{params[:id]}"
    end

    delete '/jobsite/:id/jobs/delete/:job_id' do
        job = Job.find(params[:job_id])
        job.delete
        redirect "jobsite/#{params[:id]}"
    end


end