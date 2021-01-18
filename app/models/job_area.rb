class JobArea < ActiveRecord::Base
    belongs_to :job
    belongs_to :area
end