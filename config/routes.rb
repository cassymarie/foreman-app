Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #Initial Home Page upon first visit 
  root 'sessions#new'

  #Sign-up / Log-in Routes
  resources :users, only: [:show, :new, :create]
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/signout' => 'sessions#destroy'
  
  #Google path
  get '/auth/google_oauth2/callback'=> 'sessions#omniauth'  

  resources :jobsites, only: [:index]
  
  #Nested under jobsites
  resources :jobsite, only: [:show], controller: 'jobsites' do 
    resources :jobs, only: [:index]
    get 'jobs/by_hours' => 'jobs#by_hours'
    get 'jobs/by_employees' => 'jobs#by_employees'
    get 'jobs/by_areas' => 'jobs#by_areas'

    resources :job, only: [:new, :create, :update, :edit], controller: 'jobs'
    get '/new_job_area' => 'jobs#new_area'
    post '/new_job_area' => 'jobs#create_area'
    delete 'job/:id' => 'jobs#remove'

    resources :employees, only: [:index], shallow: true
    get 'employees/by_hours' => 'employees#by_hours'
    get 'employees/by_jobs' => 'employees#by_jobs'

    resources :jobsite_employees, only: [:new, :create, :destroy], as: 'employee', controller: 'jobsite_employees'

    resources :time_entries, only: [:index], shallow: true
    get 'time_entry/by_day' => 'time_entries#by_day'

    #To be setup later
    #resources :tasks, only: [:new, :create, :edit, :update, :destroy], shallow: true
  end

  resources :admin, only: [:index]
  namespace :admin  do 
    resources :jobsites, except: [:show] do
      resources :user_jobsites, only: [:destroy], as: 'jobsite', controller: 'user_jobsites'
    end
    get 'site_crews' => 'employees#site_crews'
    resources :employees, except: [:show]
    get 'employees/search' => 'employees#search'
    resources :user_jobsites, only: [:create], as: 'jobsite', controller: 'user_jobsites'
    #delete 'user_jobsites/:jobsite_id/:id' => 'user_jobsites#remove'
  end

end
