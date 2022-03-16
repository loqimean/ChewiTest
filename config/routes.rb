Rails.application.routes.draw do
  root 'users#index'

  resources :cities
  resources :users do
    collection do
      post :search, to: "users#search"
    end
  end
end
