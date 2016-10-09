Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'
  #get  'questions/:question_id/trains/new' => 'trains#new'

  patch 'trains' => 'trains#update'
  resources :sentences, only: [:new, :create]
  resources :trains, only: [:new, :index, :create]
end
