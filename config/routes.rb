Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'

  #patch 'trains' => 'trains#update'
  get 'tops/ranking' => 'tops#ranking'
  resources :tops, only: [:show]
  resources :bots, only: [:new, :create, :edit, :update]
  resources :trains, only: [:new, :index, :create, :update, :show]
  resources :choices, only: [:index, :update]  
  get 'choices/new/:id' => 'choices#new'

  resources :evaluates, only: [:index, :new, :show] do
    resources :pairwises, only: [:index, :new, :update]
  end

end
