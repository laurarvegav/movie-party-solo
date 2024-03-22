Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    resources :discover, only: :index
    resources :movies, only: [:index, :show] do
      resources :similar, only: :index, controller: "similar_movies"
      resources :viewing_parties, only: [:new, :create, :show]
    end
  end
end
