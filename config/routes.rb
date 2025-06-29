# rubocop:disable all
Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json }, constraints: { subdomain: "api" }, path: "/" do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :products, only: [:show,:index,:create,:update,:destroy]
      resources :orders, only: [:index,:show,:create]
    end
  end
end
