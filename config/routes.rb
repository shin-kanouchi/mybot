Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'
  get 'tops/ranking' => 'tops#ranking'

  #patch 'trains' => 'trains#update'
  resources :bots, only: [:new, :create, :edit, :update, :show]
  resources :trains, only: [:new, :index, :create, :update]
  resources :choices, only: [:index, :update]  
  get 'choices/new/:id' => 'choices#new'

  resources :evaluates, only: [:index, :new, :show] do
    resources :pairwises, only: [:index, :new, :update]
  end

end
