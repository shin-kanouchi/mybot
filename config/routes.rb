Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'

  #patch 'trains' => 'trains#update'
  get 'tops/ranking' => 'tops#ranking'
  resources :tops, only: [:show]
  resources :bots, only: [:new, :create, :edit, :update]

  resources :topics, only: [:index, :show] do
    resources :trains, only: [:new, :create, :update]
    resources :choices, only: [:index, :update]  
    get 'choices/new/:id' => 'choices#new'
  end

  resources :evaluates, only: [:index, :new, :show, :create] do
    resources :pairwises, only: [:index, :update]
    get 'pairwises/new/:id' => 'pairwises#new'
  end

end
