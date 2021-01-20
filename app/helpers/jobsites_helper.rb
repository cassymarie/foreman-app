module JobsitesHelper
    def dash_button_label(collection)
        collection.size == 0 ? 'Add' : 'Add/Edit'
    end

end