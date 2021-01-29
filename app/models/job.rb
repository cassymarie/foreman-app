class Job < ActiveRecord::Base
    validates :job_number, presence: true
    validates :job_number, uniqueness: true

    has_many :job_areas
    has_many :areas, through: :job_areas
    
    accepts_nested_attributes_for :areas, reject_if: proc { |attributes| attributes['code'].blank? || attributes['name'].blank? }

    scope :active, -> { where(active: true) }
    
    belongs_to :jobsite

    after_create :create_reporting_area

    def create_reporting_area
        self.areas << Area.find_by(code: '000')
    end
end