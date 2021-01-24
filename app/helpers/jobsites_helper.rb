module JobsitesHelper

    def dash_button_label(collection)
         collection.size == 0 ? 'Add' : 'View More'
    end
    def subheader_button_label(collection)
        collection.size == 0 ? 'Add' : 'Edit'
    end

    def edit_item_link(item, show)
        #return if params[:action] == "index"
        case show
        when 'job','jobs'
            link_to "...", edit_jobsite_job_path(jobsite_id: params[:jobsite_id], id: item.id)
        when 'employee','employees'
            button_to "X", jobsite_employee_path(jobsite_id: params[:jobsite_id], id: params[:id]), method: 'delete'
        end
    end


end