Rails.application.routes.draw do
  resources :genres

  root 'genres#index'
end
