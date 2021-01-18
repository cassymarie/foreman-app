class TimeEntry < ActiveRecord::Base
    has_many :entry_types
end
