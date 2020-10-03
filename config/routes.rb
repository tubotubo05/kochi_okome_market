Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'destination', to: 'users/registrations#new_destinations'
    post 'destination', to: 'users/registrations#create_destinations'
  end

  get 'users/show'
  get "users/email" => "users#email"

  resources :cards, only: [:index, :new, :create, :destroy]

  root 'items#index'
  resources :items do
    resources :comments,only:[:new,:create,:destroy]
  end
  post "items/confirm" => "items#confirm"

  resources :purchases,only:[:index]

  namespace :api do
    resources :categories, only: [:index, :new], defaults: { format: 'json' }
  end

end

