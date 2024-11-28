Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'api/registrations',
  sessions: 'api/sessions'
}
  resources :projects
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  #Routes For Bugs
  post '/bug/create', to: 'bugs#create'      # Create a bug
  put '/bugs/update/:id', to: 'bugs#update'   # Update a bug
  get '/bugs', to: 'bugs#index'        # List all bugs
  get '/bug/:id', to: 'bugs#show'     # Show a specific bug
  delete '/bugs/delete/:id', to: 'bugs#destroy'  # Delete a bug

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
