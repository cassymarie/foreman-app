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
end