Rails.application.routes.draw do
  devise_for :users

  resources :tweets
  root to: 'home#navbar'
end
