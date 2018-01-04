Rails.application.routes.draw do

  resources :submissions
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users#show'

  resources :sessions, only: [:new, :create, :destroy]
  get 'logout', controller: 'sessions', action: 'destroy'
  resources :journals
  resources :articles
  resources :submission_events

  resources :users, only: [:new, :create, :show, :edit, :update] do
    scope module: :users do
      resources :assignments, only: [:index, :show]
    end
  end
end
