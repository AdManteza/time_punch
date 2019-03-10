Rails.application.routes.draw do
  root 'dashboard#show'

  get 'dashboard', to: 'dashboard#show', as: 'dashboard'

  resources :teachers do
    resource :time_tracks, only: [:create, :update]
  end

  resources :time_tracks, only: [:index]
end
