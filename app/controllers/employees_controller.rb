class EmployeesController < ApplicationController
    
    get '/sitecrew/:id/new' do
        redirect '/error' if !logged_in?
        @jobsite = Jobsite.find(params[:id])
        redirect '/jobsites' unless @jobsite.users.include?(current_user)

        erb :'employees/new', :layout => :'layouts/layout_sitecrew'
    end

    get '/sitecrew/:id/edit/:employee_id' do
        redirect '/error' if !logged_in?
        @jobsite = Jobsite.find(params[:id])
        redirect '/jobsites' unless @jobsite.users.include?(current_user)

        @employee = Employee.find(params[:employee_id])
        erb :'employees/edit', :layout => :'layouts/layout_sitecrew'
    end

    get '/sitecrew/:id/delete/:employee_id' do
        redirect '/error' if !logged_in?
        @jobsite = Jobsite.find(params[:id])
        redirect '/jobsites' unless @jobsite.users.include?(current_user)

        @employee = Employee.find(params[:employee_id])
        erb :'employees/delete', :layout => :'layouts/layout_sitecrew'
    end

    post '/employee/new' do
        employee = Employee.create(
            :first_name => params[:employee][:first_name],
            :last_name => params[:employee][:last_name],
            :title_id => params[:title].to_i
        )
        jobsite = Jobsite.find(params[:jobsite][:id].to_i)
        employee.jobsites << jobsite
        employee.save
        redirect "/jobsite/#{jobsite.id}/new"
    end

    patch '/employee/edit/:id' do
        jobsite = params[:jobsite][:id]
        employee = Employee.find(params[:id])
        new_info = params[:employee]
        new_info[:title_id] = new_info[:title_id].to_i
        employee.update(new_info)
        redirect "/sitecrew/#{jobsite}/new"
    end

end