class Jobsite < ActiveRecord::Base
    has_many :user_jobsites
    has_many :users, through: :user_jobsites
    accepts_nested_attributes_for :users

    has_many :jobs
    accepts_nested_attributes_for :jobs

    has_many :tasks
    accepts_nested_attributes_for :tasks

    has_many :jobsite_employees
    has_many :employees, through: :jobsite_employees
    accepts_nested_attributes_for :employees
    
    default_scope -> { order(name: :asc) }
    scope :active, -> { where(active: true )}
    scope :current, -> { where(jobsite_id: @jobsite.id )}

    after_create :create_reporting_tasks

    def site_areas
        areas=[]
        preset = Area.find(1)
        self.jobs.each do |job|
            job.areas.active.each do |area|
                if !areas.include?(area) && area != preset
                    areas << area  
                end
            end
        end
        areas.sort_by!{|a| a[:code]}
    end

    def site_users
        self.users.collect {|u| u.full_name}
    end

    def crew_size
        self.employees.size
    end

    def self.large_to_small
        sites = []
        ordered = []
        self.all.active.each do |site|
            sites << [site, site.crew_size]
        end
        sites = sites.sort_by{|s| s[1]}.reverse!.map{|s|ordered<<s[0]}
        ordered
    end

    def create_reporting_tasks
        self.tasks << Task.create(code: '275' , name: 'Job Travel')
        self.tasks << Task.create(code: '299' , name: 'General Labor')
    end

end