module JobsHelper
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

    def form_job
        params[:action] == 'new' ? @jobsite.jobs.build : Job.find_by(id: params[:id])
    end

    def form_link
        params[:action] == 'edit' ? jobsite_job_path(@jobsite.id, params[:id]) : jobsite_jobs_path(@jobsite.id)
    end

    def form_title
        params[:action] == 'edit' ? 'Edit Job' : 'Add New Job'
    end
    

end