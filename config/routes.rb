Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'

  #patch 'trains' => 'trains#update'
  resources :bots, only: [:new, :create, :edit, :update]
  resources :trains, only: [:new, :index, :create, :update]
  resources :choices, only: [:new, :index, :create, :update]

  resources :evaluates, only: [:index, :new, :show] do
    resources :pairwises, only: [:index, :new, :update]
  end

end
