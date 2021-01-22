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
        when 'jobsites','jobs','tasks','employees'
            jobsite = params[:id] || params[:jobsite_id]
            
            if jobsite.nil?
                list << link_to('Jobsites', jobsites_path) 
            else
                list << link_to('Jobsites', jobsites_path)
                jobsite = Jobsite.find_by(id: jobsite.to_i)
                list << content_tag(:strong, link_to(jobsite.name, jobsite_path(jobsite)))
                list << link_to(' - Job Information', jobsite_jobs_path(jobsite))
                list << link_to(' - Site Crew', jobsite_employees_path(jobsite))
                list << link_to(' - Time Enrty', jobsite_time_entry_index_path(jobsite))
            end
        else
            list << link_to('Jobsites', jobsites_path)
        end
        list << link_to('Log Out', signout_path, method: :delete)
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
                title << content_tag(:p, "(Foreman) #{@current_user.first_name} #{@current_user.last_name[0].capitalize}") 
        end
            title
    end
    

end


