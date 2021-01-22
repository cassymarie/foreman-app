class Jobsite < ActiveRecord::Base
    has_many :user_jobsites
    has_many :users, through: :user_jobsites

    has_many :jobs
    accepts_nested_attributes_for :jobs

    has_many :tasks
    accepts_nested_attributes_for :tasks

    has_many :jobsite_employees
    has_many :employees, through: :jobsite_employees

    after_create :create_reporting_tasks

    def site_areas
        areas=[]
        preset = Area.find(1)
        self.jobs.each do |job|
            job.areas.each do |area|
                if !areas.include?(area) && area != preset
                    areas << area  
                end
            end
        end
        areas
    end

    def create_reporting_tasks
        self.tasks << Task.create(code: '275' , name: 'Job Travel')
        self.tasks << Task.create(code: '299' , name: 'General Labor')
    end

end