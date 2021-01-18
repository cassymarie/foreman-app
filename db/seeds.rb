# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

50.times do 
    Employee.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, title_id:rand(1..7) )
end

5.times do
    Jobsite.create(name: Faker::IndustrySegments.sector)
    Jobsite.create(name: Faker::App.name)
end

25.times do 
    Job.create(job_number:rand(4501..9998), name: Faker::App.name, customer: Faker::Company.name, jobsite_id:rand(1..15))
end