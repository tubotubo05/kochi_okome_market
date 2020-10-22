Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'destinations', to: 'users/registrations#new_destination'
    post 'destinations', to: 'users/registrations#create_destination'
  end

  resources :cards, only: [:index, :new, :create, :destroy]
  resources :profiles, only: [:edit, :update]
  resources :destinations, only: [:edit, :update]

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get "bought_items"
    end
  end

  root 'items#index'
  resources :items do
    resources :comments,only:[:new,:create,:destroy]
    resources :likes, only: [:index,:create, :destroy]
    member do
      get "purchase_confirmation"
      post "purchase"
      get "cardnew"
      get 'purchased'
    end
  end

  namespace :api do
    resources :categories, only: [:index, :new], defaults: { format: 'json' }
  end


end

