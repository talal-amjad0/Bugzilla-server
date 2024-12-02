Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'api/registrations',
  sessions: 'api/sessions'
}
  resources :projects
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  #Routes For Bugs
  post '/bug/create', to: 'bugs#create'      
  put '/bugs/update/:id', to: 'bugs#update'  
  get '/bugs', to: 'bugs#index'        
  get '/bug/:id', to: 'bugs#show'
  delete '/bugs/delete/:id', to: 'bugs#destroy'

  #Routes For Project Users
  post '/project/add-users/:project_id', to: 'project_users#create'
  delete '/project/:project_id/remove-user/:id', to: 'project_users#destroy'
  get '/project/users/:project_id', to: 'project_users#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
