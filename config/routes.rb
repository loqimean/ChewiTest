Rails.application.routes.draw do
  resources :cities
  resources :users do
    collection do
      post :search, to: "users#search"
    end
  end
  root 'users#index'

  namespace :api do
    namespace :v1 do
      post :virtual_drives, to: 'virtual_drives#create'
    end
  end
end
