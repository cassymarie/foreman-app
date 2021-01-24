class Employee < ActiveRecord::Base
    has_many :jobsite_employees
    has_many :jobsites, through: :jobsite_employees
    has_many :titles

    default_scope -> { order(last_name: :asc) }
    scope :active, -> { where(active: true) }


    def full_name
        "#{self.last_name}, #{self.first_name}"
    end

    def title
        Title.find(self.title_id).title unless self.title_id.blank?
    end
    
end