module JobsitesHelper

    def dash_button_label(collection)
         collection.size == 0 ? 'Add' : 'View More'
    end
    def subheader_button_label(collection)
        collection.size == 0 ? 'Add' : 'Edit'
    end

    def render_jobs_table(customers: true, areas: true)
        return unless @jobsite.jobs.size > 0 
        @jobsite.site_areas.nil? ? areas = false : areas
        
        render_table = html_escape('')
        row_data = html_escape('')
        tbody_data = html_escape('')

        hkey = ['Job#', 'Job Name']
        hkey << 'Customers' unless !customers
        @jobsite.site_areas.each {|a| hkey << a.code } unless !areas 
        hkey.each { |key|row_data << content_tag(:th, key.to_s) }
        thead = content_tag(:thead, content_tag(:tr, row_data))

        render_table << thead

            @jobsite.jobs.each { | job | row_data = html_escape('')
                
                row_data << content_tag(:td, job.job_number) 
                row_data << content_tag(:td, job.name)
                row_data << content_tag(:td, job.customer) unless !customers
                @jobsite.site_areas.each {|a| row_data << content_tag(:td, job.areas.include?(a) ? 'X' : '') } unless !areas 

                tbody_data << content_tag(:tr, row_data)
            }

        tbody = content_tag(:tbody, tbody_data)
        render_table <<  tbody
        content_tag(:table, render_table, class: "table")
    end

end