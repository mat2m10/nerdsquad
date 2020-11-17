Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:show, :edit, :update] do
    get "all"
  end
  resources :games do
    resources :boards, only: [:new, :create]
    resources :dices, only: [:new, :create]
    resources :cards, only: [:new, :create]
    resources :pieces, only: [:new, :create]
    resources :tokens, only: [:new, :create]
  end
end
