Rails.application.routes.draw do

  root "static_pages#home"

  get '/'            => 'static_pages#home',        as: 'home'
  get '/leaderboard' => 'static_pages#leaderboard', as: 'leaderboard'

  resources :questions, only: [:index, :create, :show]
  resources :answers, only: [:create]

  devise_for :users
end
