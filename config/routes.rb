Rails.application.routes.draw do
  resources :people do
    get ':id', to: 'people#show'
  end

  resources :cities
  resources :users do
    collection do
      post :search, to: "users#search"
    end
  end
  root 'users#index'
end
