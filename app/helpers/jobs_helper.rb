module JobsHelper

    def form_job
        params[:action] == 'new' ? @jobsite.jobs.build : Job.find_by(id: params[:id])
    end

    def form_link
        params[:action] == 'edit' ? jobsite_job_path(@jobsite.id, params[:id]) : jobsite_jobs_path(@jobsite.id)
    end
    
    def form_delete_button
        return if params[:action] != 'edit'

        button_to "Remove Job", jobsite_jobs_path(jobsite_id: params[:jobsite_id], id: params[:id]), method: 'delete'
    end

    def show_customer
        table_view_by == 'index' ? true : false
    end
    
    def show_areas
        return false if table_view_by != 'index' && table_view_by != 'show'
        @jobsite.site_areas.size > 0 ? true : false
    end
    
    def jobs_checkbox_columns(j)
        num = 1
        boxes = html_escape('')
        columns = html_escape('')

        j.collection_check_boxes(:id, @jobsite.jobs, :id, :job_number) do |job|
            columns << ( job.check_box + job.label ) unless job.object.id.nil?
            num += 1
            if num == 6
                boxes << content_tag(:div, columns)
                columns = html_escape('')
                num = 1
            end
        end
        boxes << content_tag(:div, columns) unless num == 1 
        boxes
    end
end