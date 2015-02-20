Rails.application.routes.draw do
  resources :films
  resources :genres
  resources :kinds

  root 'home#index'
end
