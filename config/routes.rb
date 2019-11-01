Rails.application.routes.draw do
  devise_for :users
  resources :books do
    resources :comments
    resources :readers
  end
  root 'books#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
