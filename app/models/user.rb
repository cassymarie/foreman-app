class User < ActiveRecord::Base
    has_secure_password

    has_many :user_jobsites
    has_many :jobsites, through: :user_jobsites

    validates :first_name, presence: true
    validates :last_name, presence: true

    validates :email, presence: true
    validates :email, uniqueness: true
    
end