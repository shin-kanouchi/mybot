Rails.application.routes.draw do
  root 'sentences#index'
  #get  'questions/:question_id/trains/new' => 'trains#new'

  resources :sentences, only: [:new, :create]
  resources :trains, only: [:new, :index, :create]
end
