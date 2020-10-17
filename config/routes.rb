Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'destinations', to: 'users/registrations#new_destination'
    post 'destinations', to: 'users/registrations#create_destination'
  end


  resources :users, only: [:show, :edit]
  resources :cards, only: [:index, :new, :create, :destroy]

  root 'items#index'
  resources :items do
    resources :comments,only:[:new,:create,:destroy]
    member do
      get "purchase_confirmation"
      post "purchase"
      get "cardnew"
    end
  end

  namespace :api do
    resources :categories, only: [:index, :new], defaults: { format: 'json' }
  end


end

