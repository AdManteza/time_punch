Rails.application.routes.draw do
  root 'time_tracks#new'

  resources :time_tracks
end
