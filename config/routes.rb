Rails.application.routes.draw do

  resources :submissions
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users#show'

  resources :documents, only: [:create, :show, :destroy]
  resources :sessions, only: [:new, :index, :create,]
  get :about, controller: :pages, action: :about
  get :logout, controller: :sessions, action: :destroy
  resources :journals
  resources :articles
  resources :submission_events

  resources :passwords, only: [:new, :create]
  get :forgot, controller: :passwords, action: :forgot
  get :reset_password, controller: :passwords, action: :reset

  resources :users, only: [:new, :create, :edit, :update] do
    scope module: :users do
      resources :assignments, only: [:index, :show]
    end
  end
end
