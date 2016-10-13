Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'
  #get  'questions/:question_id/trains/new' => 'trains#new'

  patch 'trains' => 'trains#update'
  resources :trains, only: [:new, :index, :create]
  resources :choices, only: [:new, :create, :update]
  get  'evaluates/finish' => 'evaluates#finish'
  get  'evaluates/show' => 'evaluates#show'
  resources :evaluates, only: [:new] do
    patch ':pairwise_id/:inequality_flag' => 'pairwises#update'
    resources :pairwises, only: [:new]
  end

end
