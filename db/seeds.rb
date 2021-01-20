# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# TITLES = ["Foreman", "Apprentice", "Mechanic", "Superintendent", "Helper", "Jouneyman", "Classified"]

# TITLES.each{|t| Title.create(title: t)}

# 100.times do 
#     Employee.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, title_id:rand(1..7) )
# end

# 10.times do
#     Jobsite.create(name: Faker::IndustrySegments.sector)
#     Jobsite.create(name: Faker::App.name)
# end

# 50.times do 
#     Job.create(job_number:rand(4501..9998), name: Faker::App.name, customer: Faker::Company.name, jobsite_id:rand(1..20), city: Faker::Address.city, state: Faker::Address.state_abbr )
# end



# DATA = {
#     :user_keys => ['first_name', 'last_name', 'email', 'password', 'provider','admin'],
#     :users => [
#         ['Peter', 'Agustus', 'peter@email.com', 'password', 'email', false],
#         ['Lynn', 'Bigelow', 'lynn@email.com', 'password', 'email', false],
#         ['Sean', 'Smith', 'sean@email.com', 'password', 'email', true],
#         ['John', 'Doe', 'john@email.com', 'password', 'email', false],
#         ['Cassy', 'Ortega', 'cassy@email.com', 'password', 'email', true],
#         ['Jack', 'Manning', 'jack@email.com', 'password', 'email', false],
#         ['Maricela', 'Calderano', 'maricela@email.com', 'password', 'email', false]
#     ]
# }

# DATA[:users].each do |user|
#     new_user = User.new
#     user.each_with_index do |attribute, i|
#         new_user.send(DATA[:user_keys][i] + "=", attribute)
#     end
#     new_user.save
# end

# 20.times {
#     UserJobsite.create(user_id:rand(5..13), jobsite_id: rand(1..21))
# }

# Employee.all.each do |e|
#     JobsiteEmployee.create(employee_id: e.id, jobsite_id:rand(1..21))
# end