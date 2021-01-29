module ApplicationHelper

    def header_user
        "#{@current_user.admin ? '(Admin) ' : ''}#{@current_user.first_name} #{@current_user.last_name[0].capitalize}."
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


