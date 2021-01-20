class TasksController < ApplicationController

    get '/jobsite/:id/tasks' do
        redirect '/error' if !logged_in?
        @jobsite = Jobsite.find(params[:id])
        redirect '/jobsites' unless @jobsite.users.include?(current_user)
        @tasks = @jobsite.tasks
        erb :'tasks/add', :layout => :'layouts/layout_tasks'
    end

    get '/jobsite/:id/task/edit/:task_id' do
        redirect '/error' if !logged_in?
        @jobsite = Jobsite.find(params[:id])
        redirect '/jobsites' unless @jobsite.users.include?(current_user)

        @tasks = @jobsite.tasks
        @task = Task.find(params[:task_id])
        erb :'tasks/edit', :layout => :'layouts/layout_tasks'
    end

    get '/jobsite/:id/task/delete/:task_id' do
        redirect '/error' if !logged_in?
        @jobsite = Jobsite.find(params[:id])
        redirect '/jobsites' unless @jobsite.users.include?(current_user)

        @tasks = @jobsite.tasks
        @task = Task.find(params[:task_id])
        erb :'tasks/delete', :layout => :'layouts/layout_tasks'
    end 


    patch '/task/edit/:task_id' do
        jobsite = Jobsite.find(params[:jobsite_id])
        task = Task.find_by(:id => params[:task_id])
        task[:code] = params[:task][:code].upcase
        task[:name] = params[:task][:name].capitalize
        task.save
        redirect "jobsite/#{jobsite.id}/tasks"
    end

    post '/task/new' do
        task = Task.create(params[:task])
        jobsite = Jobsite.find(params[:jobsite_id])
        task.code.upcase!
        task.name.capitalize!
        jobsite.tasks << task
        jobsite.save
        redirect "jobsite/#{jobsite.id}/tasks"
    end


    delete '/task/delete/:task_id' do
        jobsite = Jobsite.find(params[:jobsite_id])
        task = Task.find(params[:task_id])
        task.delete
        redirect "jobsite/#{jobsite.id}/tasks"
    end

end
