Rails.application.routes.draw do
  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    resources :discover, only: :index
    resources :movies, only: [:index, :show] do
      resources :similar, only: :index, controller: "similar_movies"
      resources :viewing_parties, only: [:new, :create, :show]
    end
  end
  
  get "/login", to: 'sessions#new'
  post "/login", to: 'sessions#create'
  delete "/logout", to: 'sessions#destroy'

  namespace :admin do
    get "/dashboard", to: "dashboard#index"
    get "/users/:id", to: "dashboard#users"
  end
end
