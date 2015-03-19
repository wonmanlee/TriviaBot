Rails.application.routes.draw do

  root "static_pages#home"

  get '/'            => 'static_pages#home',        as: 'home'
  get '/leaderboard' => 'static_pages#leaderboard', as: 'leaderboard'

  resources :answers, only: [:index, :create, :show]

  devise_for :users
end
