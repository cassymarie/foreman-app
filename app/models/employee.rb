class Employee < ActiveRecord::Base
    has_many :jobsite_employees
    has_many :jobsites, through: :jobsite_employees
    has_many :titles

    default_scope -> { order(full_name: :desc) }

    def full_name
        "#{self.last_name}, #{self.first_name}"
    end

    def title
        Title.find(self.title_id).title unless self.title_id.blank?
    end
end