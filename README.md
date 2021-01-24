# Jobsite Log (Rails)

This rails app will setup a Jobsite that will track multiple jobs, areas and their employees.  The Jobsite will have multiple jobs that will be worked on by many employees.  Each Job will have many areas and many tasks.  Each employee can work on many jobs, in many areas and do many tasks in each area.  

*For the current project, tasks have been setup in the database but have not been routed with views*

## Installation

1. Clone the jobsite log: `git clone 'https://github.com/cassymarie/foreman-app'`
2. Go into the cli directory `foreman-app`
3. Run `bundle install`
4. Run `rails s`
5. Open your browser and go to the local server: `http://localhost:3000/`

## Usage

In order to use the jobsite_log, users will need to login or signup.  Follow the prompt sign-in screen to get access to your jobsites.  A user is able to signup and login with OmniAuth through Google.

Once a user is signed in, they will be taken to the jobsite dashboard which shows all the jobsite the user has setup.  By clicking on the specific jobsite name, the user will be taken to that jobsite dashboard page where they can add/edit specific jobs, employees, and more.  

Currently this is a work-in-progress app, and that some CRUD fucntions will not be available to non-admin users. The destroy capabilities will not permantely delete records, only mark `:active = false` or remove from a join table.

Navigation buttons are located in the top right corner of the header.  This will update based on the current view page.

On the main Index page for both Jobs/Employees - You will be able to filter recorded hours (*coming soon*) by category selected (i.e. Jobs can view by Employees or by Areas)

Additionally, there is the Time Entry form - that allows the user to enter in time worked by job/task/area for each individual.  *Currently, this will will only navigate to the index page - More to come with Javascript*

## Rails Project Requirements

Specs:

- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (*User has_many Jobsites*)
- [x] Include at least one belongs_to relationship (*Job belongs_to Jobsite*)
- [x] Include at least two has_many through relationships (*Area has_many jobs through job_areas*; *Jobsite has_many Users through UserJobsites*)
- [X] Include at least one many-to-many relationship (*Jobsite has_many Employees through JobsiteEmployees, Employee has_many Jobsites through JobsiteEmployees*)
- [X] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (*Job can accept nested area_attributes*)
- [X] Include reasonable validations for simple model objects (*Job validates presence/uniqueness of job_number*)
- [X] Include a class level ActiveRecord scope method (*Employees model: default_scope{ order(last_name: :asc) }, active{ where(active: true) }* )
- [X] Include signup
- [X] Include login
- [X] Include logout
- [X] Include third party signup/login (*OmniAuth Google*)
- [X] Include nested resource show or index (*Jobsite/2/Employees*)
- [X] Include nested resource "new" form (*Jobsite/1/jobs/* -- All routes are within Index page)
- [X] Include form display of validation errors (*Flash[:alert] for Sign and Login*)

Confirm:

- [X] The application is pretty DRY
- [X] Limited logic in controllers
- [X] Views use helper methods if appropriate
- [X] Views use partials if appropriate

## Development

All work has been completed on the `origin-master` branch.  Multiple commits have been made throughout the development of the app.  

Future development ideas:  

- Develop the Admin controls
  - ADD New Jobsites and Employees
  - Assign Jobsites to Users
- Total hours can be represented on the Index page
- Daily time entry will generate reports
- Admin status to view all jobsites created.
- Weekly data hours will generate time cards.
- Validate remove of item from table -- inactivate if exists on the weekly_time table.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).