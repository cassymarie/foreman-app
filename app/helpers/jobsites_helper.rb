module JobsitesHelper

    def edit_item_link(item)
        return unless control != 'jobsite'
        case current_section
        when 'Jobs'
            link_to(content_tag(:span,'', class:"glyphicon glyphicon-pencil"),edit_jobsite_job_path(jobsite_id: @jobsite.id, id: item.id))
        when 'Employees'
            button_to jobsite_employee_path(jobsite_id: @jobsite.id, id: item.id), { method: :delete, remote: true, class: "remove-btn", controller: 'jobsite_employees' }  do 
                content_tag(:span,'', class:"glyphicon glyphicon-remove")
            end
        end
    end

    def current_section_link(section)
        return link_to(content_tag(:span,'', class:"glyphicon glyphicon-chevron-up"), jobsite_path(@jobsite)) if section == current_section
        case section 
        when 'Jobs'
            link_to(content_tag(:span,'', class:"glyphicon glyphicon-chevron-down"), jobsite_jobs_path(@jobsite))
        when 'Employees'
            link_to(content_tag(:span,'', class:"glyphicon glyphicon-chevron-down"), jobsite_employees_path(@jobsite))
        when 'Time Entry'
            link_to(content_tag(:span,'', class:"glyphicon glyphicon-chevron-down"), jobsite_time_entries_path(@jobsite))
        end
    end

    def has_areas?
        @jobsite.site_areas.size > 0 ? true : false
    end

    def has_employees?
        @jobsite.employees.active.size > 0 ? true : false
    end

    def active_button(btn_action)
        return 'active' if control == 'jobsite_employees' && btn_action == 'index'
        return 'active' if (view_by == 'new' || view_by == 'new_area' || view_by == 'edit') && btn_action == 'index'
        params[:action] == btn_action ? 'active' : ''
    end

    def current_section
        case control
        when 'employees','jobsite_employees'
            'Employees'
        when 'jobs'
            'Jobs'
        when 'time_entries'
            'Time_Entry'
        end 
    end

    def view_by
        params[:action]
    end

    def control
        params[:controller]
    end

    def edit_table
        special_views.include?(view_by) ? false : true
    end

    def section_control
        {
            :Employees => { 
                :controllers => ['employees','jobsite_employees'],
                :sub_nav => ['by_hours','by_jobs'],
                :collection => @jobsite.employees.active,
                :stationary_headers => ['Name'],
                :stationary_info => ['full_name'],
                :index_headers => ['Title'],
                :index_info => [:title]
            },
            :Jobs => {
                :controllers => ['jobs'],
                :sub_nav => ['by_hours','by_employees','by_areas'],
                :collection => @jobsite.jobs.active,
                :stationary_headers => ['Job#','Name'],
                :stationary_info => [:job_number,:name],
                :index_headers => ['Customer'],
                :index_info => [:customer]
            },
            :Time_Entry => {
                :controllers => ['time_entries'],
                :sub_nav => ['MON','TUE','WED','THUR','FRI','SAT','SUN'],
                :stationary_headers => ['Name', 'Job','Task','Area','Reg','OT','DT'],
                :stationary_info => [:full_name],
                :index_headers => [],
                :index_info => []
            }
        }
    end

    def available_sections
        section_control.keys.collect{|k| k.to_s.tr("_"," ")}
    end

    def view_by_header
        return if control == "jobsites"
        header = {
        :by_hours => ['Reg','OT','DT','Total'],
        :by_employees => [],
        :by_areas => [],
        :by_jobs => []
        }

        Title.all.sort_by{ |a| a[:title] }.map do |t|
            header[:by_employees] << t.title[0]
        end
        @jobsite.site_areas.map do |a|
            header[:by_areas] << a.code.upcase
        end

        @jobsite.jobs.active.sort_by{ |a| a[:job_number] }.map do |j|
            header[:by_jobs] << j.job_number
        end

        header
    end


end