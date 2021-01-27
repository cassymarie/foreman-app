module JobsitesHelper

    def dash_button_label(collection)
         collection.size == 0 ? 'Add' : 'View More'
    end
    def subheader_button_label(collection)
        collection.size == 0 ? 'Add' : 'Edit'
    end

    def edit_item_link(item, show)
        case show
        when 'job','jobs'
            link_to(content_tag(:span,'', class:"glyphicon glyphicon-pencil"),edit_jobsite_job_path(jobsite_id: params[:jobsite_id], id: item.id))
        when 'employee','employees'
            button_to content_tag(:span,'', class:"glyphicon glyphicon-pencil"), jobsite_employee_path(jobsite_id: params[:jobsite_id], id: item.id), method: 'delete'
        end
    end

    def table_view_by
        params[:action]
    end

    def edit_table
        allowed = ['index','show','edit','new','new_job_area']
        allowed.include?(table_view_by) ? true : false
    end

    def form_title
        params[:action] == 'edit' ? 'Edit' : 'Add New'
    end

end