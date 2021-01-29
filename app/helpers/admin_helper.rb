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
                :stationary_headers => ['Name'],
                :stationary_info => ['full_name'],
                :index_headers => ['Title'],
                :index_info => [:title]
            },
            :Users => {
                :controllers => ['admin/users'],
                :sub_nav => []
            }
        }
    end

    def current_admin_section
        admin_control.map {|k,v| return k.to_s if v[:controllers].include?(control)} 
    end

    def edit_admin_item_link(item)
        link_to(content_tag(:span,'', class:"glyphicon glyphicon-pencil"),"/admin/#{current_admin_section.downcase}/#{item.id}/edit")
    end

    def delete_admin_item_link(item)
        button_to "/admin/#{control.downcase}/#{item.id}", { method: :delete, remote: true, class: "remove-btn", controller: control }  do 
            content_tag(:span,'', class:"glyphicon glyphicon-remove")
        end
    end

    def admin_text(item, info)
       if info == :full_name 
        item.full_name 
       elsif info == :site_users 
        item.site_users.join(" / ")
       else
         item[info]
       end 
    end
end