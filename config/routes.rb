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

  resources :jobsites, only: [:index]
  #Nested under jobsites
  resources :jobsite, controller: 'jobsites' do 
    resources :jobs, except: [:index]
    resources :tasks
    resources :employees
  end

  # namespace :dashboard do
  #   root to: "users#show"
  # end
end
