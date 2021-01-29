class Employee < ActiveRecord::Base
    has_many :jobsite_employees
    has_many :jobsites, through: :jobsite_employees
    has_many :titles
    accepts_nested_attributes_for :titles

    default_scope -> { order(last_name: :asc) }
    scope :active, -> { where(active: true) }
    scope :search, -> (text){ 
        where(
            column_names
                .map {|field| "#{field} like '%#{text}%'" }
                .join(" or ")
            )
        }



    def full_name
        "#{self.last_name}, #{self.first_name}"
    end

    def title
        Title.find(self.title_id).title unless self.title_id.blank?
    end
    
end