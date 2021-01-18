class JobsiteEmployee < ActiveRecord::Base
    belongs_to :jobsite
    belongs_to :employee
end