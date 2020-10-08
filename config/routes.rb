Rails.application.routes.draw do
  root 'items#index'
<<<<<<< Updated upstream
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
=======

  resources :items, only: [:index, :new, :create, :show]
  post "items/confirm" => "items#confirm"
>>>>>>> Stashed changes
end
