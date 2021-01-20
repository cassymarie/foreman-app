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
                list << link_to('Log In', signin_path)
            else
                list << link_to('Jobsites', jobsites_path)
                list << link_to('Log Out', signout_path, method: :delete) 
            end
        when 'sessions'
            list << link_to('Sign Up', new_user_path)
        when 'admin'
            list << link_to('Admin(test)', dashboard_root_path)
        when 'jobsites'
            if a != 'index'
                list << link_to('Jobsites', jobsites_path)
            end
            
            list << link_to('Log Out', signout_path, method: :delete)
        else
            list << link_to('Sign Up', new_user_path)
            list << link_to('Log In', signin_path)
        end

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


