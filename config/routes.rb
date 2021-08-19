Rails.application.routes.draw do
  resources :cities
  resources :users do
    collection do
      post :search, to: "users#search"
    end
  end
  root 'users#index'
end
