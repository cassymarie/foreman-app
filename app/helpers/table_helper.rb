module TableHelper
    def thead
        content_tag :thead do
            content_tag :tr do
                content_tag :th, "header col 1"
            end
        end     
    end
    
    def tbody
        content_tag :tbody do
          tr1 = content_tag :tr do
            content_tag :td, "body col 1"
          end
          tr2 = content_tag :tr do
            content_tag :td, "body col 1 row 2"
          end
          tr1 + tr2
        end
      end
    
      def table
        content_tag :table do
          thead + tbody
        end
      end

end