Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

  resources :items, only: [:index, :new, :show]

  namespace :api do
    resources :categories, only: :index, defaults: { format: 'json' }
  end

end
