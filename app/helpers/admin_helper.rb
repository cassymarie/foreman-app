module AdminHelper
    include JobsitesHelper

    def admin_control
        {
            :Jobsites => {
                :controllers => ['admin/jobsites','admin/user_jobsites'],
                :collection => Jobsite.all,
                :stationary_headers => ['Jobsite','City','State','Users'],
                :stationary_info => [:name, :city, :state, :site_users]
            },
            :Employees => { 
                :controllers => ['admin/employees'],
                :sub_nav => ['by_hours','by_jobs'],
                :collection => Employee.all.active,
                :stationary_headers => ['Name','Title'],
                :stationary_info => ['full_name','title'],
                :index_headers => ['Title'],
                :index_info => [:title]
            }
        }
    end

    def available_admin_sections
        admin_control.keys.collect{|k| k.to_s}
    end

    def current_admin_section
        return control if control == "admin"
        admin_control.map {|k,v| return k.to_s if v[:controllers].include?(control)} 
    end

    def current_admin_section_link(section)
        return link_to(content_tag(:span,'', class:"glyphicon glyphicon-chevron-up"), admin_index_path) if section == current_admin_section 
        case section 
        when 'Jobsites'
            link_to(content_tag(:span,'', class:"glyphicon glyphicon-chevron-down"), admin_jobsites_path)
        when 'Employees'
            link_to(content_tag(:span,'', class:"glyphicon glyphicon-chevron-down"), admin_employees_path)
        end
    end

    def edit_admin_item_link(item)
        link_to(content_tag(:span,'', class:"glyphicon glyphicon-pencil"),"/admin/#{current_admin_section.downcase}/#{item.id}/edit")
    end

    def delete_admin_item_link(item)

        case current_admin_section
        when 'Jobsites'
            button_to admin_jobsite_path(item.id), { method: :delete, remote: true, class: "remove-btn", controller: 'admin/jobsites' }  do 
                content_tag(:span,'', class:"glyphicon glyphicon-remove")
            end
        when 'Employees'
            button_to admin_employee_path(item.id), { method: :delete, remote: true, class: "remove-btn", controller: 'admin/employees' }  do 
                content_tag(:span,'', class:"glyphicon glyphicon-remove")
            end
        end
    end

    def admin_text(item, info)
       if info == 'full_name'
        item.full_name 
       elsif info == 'title'
        item.title 
       elsif info == :site_users 
        item.site_users.join(" / ")
       else
         item[info]
       end 
    end
    def admin_collection
        if current_admin_section == 'Jobsites'
            @jobsites
        else
            @employees
        end
    end
end