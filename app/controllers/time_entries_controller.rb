class TimeEntriesController < ApplicationController
    get '/jobsite/:id/time_entry' do
        redirect '/error' if !logged_in?
        @jobsite = Jobsite.find(params[:id])
        redirect "/jobsite/#{@jobsite.id}" unless @jobsite.users.include?(current_user)
        @week_ending = DateTime.parse(params[:week_ending]).to_date

        erb :'time_entries/show', :layout => :'layouts/layout_time_entries'
    end

    get '/jobsite/:id/time_entry/by_day' do
        @jobsite = Jobsite.find(params[:id])
        @week_ending = DateTime.parse(params[:week_ending]).to_date

        if !params[:work_date].nil? 
            @sub_days = params[:work_date].to_i 
            @workdate = @week_ending - @sub_days.days
        end

        @posted = false
        
        erb :'time_entries/show', :layout => :'layouts/layout_time_entries'
    end

    post '/jobsite/:id/time_entry/new' do
        @jobsite = Jobsite.find(params[:id])
        @week_ending = DateTime.parse(params[:week_ending]).to_date
        @workdate = DateTime.parse(params[:workdate]).to_date
        employee_entry = params[:entry]
            employee_entry.each do |entry|
                employee = entry[:employee]
                hours = entry[:hours]
                    type = 1
                    hours.each do |k,v|
                        if !v==""
                            binding.pry
                            post = TimeEntry.create(employee)
                            post.workdate = @workdate
                            post.hours = v.to_f
                            post.type_id = type
                            post.save
                        end
                        type += 1
                    end
            end
        @message = "Time has been posted for #{@workdate}"
        
        erb :'time_entries/show', :layout => :'layouts/layout_time_entries'
    end
end