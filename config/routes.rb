Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:show, :edit, :update] do
    get "all"
  end
  get "boards/new", to: "boards#new", as: :new_board
  get "games/new", to: "games#new", as: :new_game
end
