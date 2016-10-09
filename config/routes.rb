Rails.application.routes.draw do
  root 'trains#index'
  #get  'questions/:question_id/trains/new' => 'trains#new'

  patch 'trains' => 'trains#update'
  resources :sentences, only: [:new, :create]
  resources :trains, only: [:new, :index, :create]
end
