# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :books do
    put :take, on: :member
    put :return, on: :member
    # post :rating, on: :member
    resources :comments
    resources :historys
    resources :likes
  end
  root 'books#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
