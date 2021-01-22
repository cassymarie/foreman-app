Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #Initial Home Page upon first visit 
  root 'sessions#new'

  #Sign-up / Log-in Routes
  resources :users, only: [:show, :new, :create]
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  delete '/signout' => 'sessions#delete'
  
  #Google path
  get '/auth/google_oauth2/callback'=> 'sessions#omniauth'  

  resources :jobsites, only: [:index, :show]
  #Nested under jobsites
  resources :jobsite, only: [:new, :edit, :create], controller: 'jobsites' do 
    resources :jobs, only: [:index, :create], shallow: true
    resources :job, only: [:new, :update, :edit], controller: 'jobs', shallow: true
    resources :employees, only: [:index, :create, :update], shallow: true
   # resources :employees, only: [:index, :new,:create, :update, :destroy]
    resources :time_entry, only: [:index, :new], shallow: true
    resources :tasks, only: [:new, :create, :edit, :update, :destroy], shallow: true
    post '/new_job_area' => 'jobs#new_area'
  end



  # get '/new_job_area' => 'jobs#new_area'
  # post '/new_job_area' => 'jobs#create_area'

  # namespace :dashboard do
  #   root to: "users#show"
  # end
end
