Rails.application.routes.draw do
  root 'users#index'

  get '/drive/(:folder_id)', to: 'virtual_drives#drive', as: :drive

  resources :cities
  resources :users do
    collection do
      post :search, to: "users#search"
    end
  end

  namespace :api do
    namespace :v1 do
      post :virtual_drives, to: 'virtual_drives#create'
    end
  end
end
