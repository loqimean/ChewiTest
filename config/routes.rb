Rails.application.routes.draw do
  resources :people

  resources :cities
  resources :users do
    collection do
      post :search, to: "users#search"
    end
  end
  root 'users#index'
end
