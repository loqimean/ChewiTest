Rails.application.routes.draw do
  resources :cities
  resources :users do
    collection do
      post :search, to: "users#search"
    end
  end
  root 'users#index'

  post :virtual_drives, to: 'virtual_drives#create'
end
