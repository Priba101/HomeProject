Rails.application.routes.draw do
  devise_for :users
  resources :todos
  #root 'home#index'
  root 'todos#index'
  get 'home/index'
  get 'home/about'
  get 'home/youtube'
end