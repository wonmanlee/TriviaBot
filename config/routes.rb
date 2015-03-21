Rails.application.routes.draw do

  root "static_pages#home"

  get '/'            => 'static_pages#home',        as: 'home'
  get '/leaderboard' => 'static_pages#leaderboard', as: 'leaderboard'

  resources :questions, only: [:index, :create, :show]  do
    resources :answers, only: [:create, :show]
  end

  devise_for :users
end
