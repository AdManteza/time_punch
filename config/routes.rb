Rails.application.routes.draw do
  root 'time_tracks#new'

  resources :teachers do
    resource :time_tracks, only: [:create, :update]
  end

  resources :time_tracks, only: [:index, :new]
end
