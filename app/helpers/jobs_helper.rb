module JobsHelper
    
    def form_job
        params[:action] == 'new' ? @jobsite.jobs.build : Job.find_by(id: params[:id])
    end

    def form_link
        params[:action] == 'edit' ? jobsite_job_path(@jobsite.id, params[:id]) : jobsite_jobs_path(@jobsite.id)
    end
    
    def form_delete_button
        return if params[:action] != 'edit'

        button_to "Remove Job", jobsite_job_path(jobsite_id: params[:jobsite_id], id: params[:id]), method: 'delete',  :class => 'edit-btn delete'
    end

    def area_included?(area)
        return false if params[:id].nil?
        Job.find(params[:id]).areas.include?(area) ? true : false
    end

    def show_customer
        allowed = ['index','show','edit','new_job_area']
        allowed.include?(table_view_by) ? true : false
    end
    
    def show_areas
        allowed = ['index','show','edit','new_job_area','by_areas']
        allowed.include?(table_view_by) && @jobsite.site_areas.size > 0 ? true : false
    end
    
    def jobs_checkbox_columns(j)
        num = 1
        boxes = html_escape('')
        columns = html_escape('')

        j.collection_check_boxes(:id, @jobsite.jobs, :id, :job_number) do |job|
            columns << ( job.check_box + job.label ) unless job.object.id.nil?
            num += 1
            if num == 8
                boxes << content_tag(:div, columns)
                columns = html_escape('')
                num = 1
            end
        end
        boxes << content_tag(:div, columns) unless num == 1 
        boxes
    end
end