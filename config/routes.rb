Rails.application.routes.draw do
  resources :polls


# MAIN STUFF
  resources :problems, only: [:create]
  get '/solver', to: 'problems#index', :as => :solver
  get '/solver/post', to: 'problems#new', :as => :post_problem
  post '/solver/sponsor', to: 'problems#sponsor', :as => :sponsor_criteria
  post '/solver/unsponsor', to: 'problems#unsponsor', :as => :unsponsor_criteria
  post '/solver/dissent', to: 'problems#dissent', :as => :dissent_criteria
  post '/solver/assent', to: 'problems#assent', :as => :assent_criteria

  get '/solver/:problem_id', to: 'problems#show', :as => :issue

  resources :solutions, only: [:create]
  get '/solver/:problem_id/solution/new', to: 'solutions#new', :as => :new_solution
  get '/solver/:problem_id/solution/:solution_id', to: 'solutions#show', :as => :solution
  post '/solver/poll', to: 'solutions#poll', :as => :set_poll

  resources :activities, only: [:create]
  get '/activator', to: 'activities#index', :as => :activator
  get '/activator/post', to: 'activities#new', :as => :post_action
  get '/activator/:activity_id', to: 'activities#show', :as => :action
  post '/activator/participate/:roll_id', to: 'activities#participate', :as => :participate

  get 'commitments', to: 'static#commitments', :as => :commitment

  post '/criteria/add', to: 'criteria#add', :as => :add_criterium
  resources :criteria

# MAIN STUFF ENDS




  get 'password_resets/new'

  get 'password_resets/edit'

  root   'activities#index'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end