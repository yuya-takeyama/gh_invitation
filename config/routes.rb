Rails.application.routes.draw do
  get 'login'  => 'sessions#login'
  post 'logout' => 'sessions#logout'

  post 'invite' => 'top#invite'

  get 'auth/github/callback' => 'sessions#callback'

  root 'top#index'
end
