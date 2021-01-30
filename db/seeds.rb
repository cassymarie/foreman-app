# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

TITLES = ["Foreman", "Apprentice", "Mechanic", "Superintendent", "Helper", "Jouneyman", "Classified"]

TITLES.each{|t| Title.create(title: t)}

150.times do 
    Employee.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, title_id:rand(1..7) )
end

5.times do
    Jobsite.create(name: Faker::IndustrySegments.sector, city: Faker::Address.city, state: Faker::Address.state_abbr)
    Jobsite.create(name: Faker::App.name, city: Faker::Address.city, state: Faker::Address.state_abbr)
    Jobsite.create(name: Faker::Space.galaxy, city: Faker::Address.city, state: Faker::Address.state_abbr)
end

Area.create(code: '000', name: 'General')

50.times do 
    Job.create(job_number:rand(4501..9998), name: Faker::App.name, customer: Faker::Company.name, jobsite_id:rand(1..15))
end

150.times do
    Task.create(code:rand(200..298), name: Faker::Hipster.sentence(word_count: rand(1..2), supplemental: false, random_words_to_add: rand(0..2)) , jobsite_id:rand(1..15))
end

50.times do
    Area.create(code: Faker::Alphanumeric.alphanumeric(number: 3).upcase!, 
    name: Faker::Hipster.sentence(word_count: rand(1..2), supplemental: false, random_words_to_add: rand(0..1)) 
    )
end

DATA = {
    :user_keys => ['first_name', 'last_name', 'email', 'password', 'provider','admin'],
    :users => [
        ['Peter', 'Agustus', 'peter@email.com', 'password', 'email', false],
        ['Lynn', 'Bigelow', 'lynn@email.com', 'password', 'email', false],
        ['Sean', 'Smith', 'sean@email.com', 'password', 'email', true],
        ['John', 'Doe', 'john@email.com', 'password', 'email', false],
        ['Cassy', 'Ortega', 'cassy@email.com', 'password', 'email', true],
        ['Jack', 'Manning', 'jack@email.com', 'password', 'email', false],
        ['Maricela', 'Calderano', 'maricela@email.com', 'password', 'email', false]
    ]
}

DATA[:users].each do |user|
    new_user = User.new
    user.each_with_index do |attribute, i|
        new_user.send(DATA[:user_keys][i] + "=", attribute)
    end
    new_user.save
end

35.times {
    UserJobsite.create(user_id:rand(5..13), jobsite_id: rand(1..15))
}

admin1 = User.create(first_name:'Frank', last_name:'Dukes', email:'frank@email.com', password:'password', provider:'email', admin: true)
admin2 = User.create(first_name:'Amanda', last_name:'Mitchell', email:'amanda@email.com', password:'password', provider:'email', admin: true)

3.times{
    UserJobsite.create(user_id: admin1.id, jobsite_id: rand(1..15))
    UserJobsite.create(user_id: admin2.id, jobsite_id: rand(1..15))
}

Employee.all.each do |e|
    JobsiteEmployee.create(employee_id: e.id, jobsite_id:rand(1..15))
end

EntryType.create(code: 'R', description: 'Regular Time')
EntryType.create(code: 'O', description: 'OverTime')
EntryType.create(code: 'D', description: 'Double Time')
EntryType.create(code: 'T', description: 'Travel Time')

150.times do
    JobArea.create(job_id:rand(1..50), area_id:rand(1..200))
end

1000.times {
    rand_job = rand(1..50)
    employee = rand(1..150)
    job = Job.find_by(id: rand_job)
    jobsite = job.jobsite
    num = rand(0.5..8.0).round(2)
    entry = rand(0..3)

    TimeEntry.create(
        workdate: Faker::Date.between(from: 8.months.ago, to: Date.today),
        jobsite_id: jobsite.id,
        employee_id: employee,
        job_id: rand_job,
        area_id: job.areas.sample.id,
        task_id: jobsite.tasks.sample.id,
        hours: num,
        entry_id: entry
    )
}