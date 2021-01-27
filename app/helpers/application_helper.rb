module ApplicationHelper
    def error_message(model)
        message = html_escape('')
        if error = model.errors
            error.full_messages.each do |e|
                message << content_tag(:p, e)
            end
            message << content_tag('br')
            message
        end
    end

    def page_title
        case params[:controller]
        when 'jobsites'
            if params[:action] == "index"
                'Jobsites' 
            else
                @jobsite.name
            end
        when 'sessions','users'
            'Field Foreman App'
        when 'jobsites','jobs','tasks','employees','time_entries'
            @jobsite.name
        else
            'Field Foreman App'
        end
    end

    def header_links
        a = params[:action]
        list = html_escape('')
        case params[:controller]
        when 'users','admin'
            if a == 'new'
              return  list << link_to('Log In', signin_path)
            else
                list << link_to('Jobsites', jobsites_path)
            end
        when 'sessions'
            return list << link_to('Sign Up', new_user_path)
        when 'admin'
            list << link_to('Admin(test)', dashboard_root_path)
        when 'jobsites','jobs','tasks','employees','time_entries'
            jobsite = params[:jobsite_id] || params[:id]
            
            if jobsite.nil?
                list << link_to('Jobsites', jobsites_path) 
            else
                list << link_to('Jobsites', jobsites_path)
                jobsite = Jobsite.find_by(id: jobsite)
                list << content_tag(:strong, link_to(jobsite.name, jobsite_path(jobsite)))
                list << link_to(' - Job Information', jobsite_jobs_path(jobsite))
                list << link_to(' - Site Crew', jobsite_employees_path(jobsite))
                list << link_to(' - Time Enrty', jobsite_time_entries_path(jobsite))
            end
        else
            list << link_to('Jobsites', jobsites_path)
        end
        list << content_tag(:a, button_to('Log Out', signout_path), class: "logout_button")
        list
    end

    def header_right
        title = html_escape('')
        case params[:controller]
        when 'users','sessions'
                params[:action] == 'show' ? title << content_tag(:p, "(Foreman) #{@current_user.first_name} #{@current_user.last_name[0].capitalize}") : ''
                
        when 'admin'
                title << content_tag(:p, "(Admin) #{@current_user.first_name} #{@current_user.last_name[0].capitalize}")
        else
                title << content_tag(:p, "#{@current_user.first_name} #{@current_user.last_name[0].capitalize}") 
        end
            title
    end
    
    def current_jobsite
        @jobsite = Jobsite.find_by(id: params[:jobsite_id]) || Jobsite.find_by(id: params[:id])
    end

end


