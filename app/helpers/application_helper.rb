module ApplicationHelper


    def signup_errors(model)
        if err = model.errors
            err.full_messages.join(" ")
        end
    end
end
