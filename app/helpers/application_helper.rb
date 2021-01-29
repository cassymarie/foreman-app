module ApplicationHelper

    def view_by
        params[:action]
    end

    def control
        params[:controller]
    end

    def header_user
        "#{@current_user.admin ? '(Admin) ' : ''}#{@current_user.first_name} #{@current_user.last_name[0].capitalize}."
    end

    def header_title
        view_by == "site_crews" ? 'Field Site Crews' : 'Field Jobsite App'
    end

    def current_date
        Time.new.strftime("%A, %B %d") 
    end

    def current_jobsite
        @jobsite = Jobsite.find_by(id: params[:jobsite_id]) || Jobsite.find_by(id: params[:id])
    end

    def special_views
        ['by_jobs','by_employees','by_hours','by_areas']
    end


end


