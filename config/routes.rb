Rails.application.routes.draw do
  resources :users do
    collection do
      post :search, to: "users/searches#index"
    end
  end
  root 'users#index'
  resources :users
end
