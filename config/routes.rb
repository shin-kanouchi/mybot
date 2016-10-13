Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'

  #patch 'trains' => 'trains#update'
  resources :bots, only: [:new, :create, :update]
  resources :trains, only: [:new, :index, :create, :update]
  resources :choices, only: [:new, :create, :update]
  
  get  'evaluates/finish' => 'evaluates#finish'
  resources :evaluates, only: [:new, :show] do
    resources :pairwises, only: [:new, :update]
  end

end
