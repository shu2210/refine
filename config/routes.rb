# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: '/letters' if Rails.env.development?

  root to: 'codes#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  namespace :codes do
    resources :drafts
    resources :likes
    resources :dislikes
    resources :histories
  end
  resources :codes
  namespace :users do
    resources :profiles
    resources :change_passwords
  end
  resources :reviews
  namespace :comments do
    resources :resolutions
  end
  resources :comments
end
