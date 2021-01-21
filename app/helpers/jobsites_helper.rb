module JobsitesHelper
    def dash_button_label(collection)
         collection.size == 0 ? 'Add' : 'View More'
    end
    def subheader_button_label(collection)
        collection.size == 0 ? 'Add' : 'Edit'
    end
end