Rails.application.routes.draw do
  get 'users/show'
  devise_for :users

  root 'items#index'



  resources :items do
    resources :comments,only:[:new,:create,:destroy]
  end

  namespace :api do
    resources :categories, only: :index, defaults: { format: 'json' }
  end


end
