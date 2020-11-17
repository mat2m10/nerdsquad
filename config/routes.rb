Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:show, :edit, :update] do
    get "all"
  end
  resources :games do
    resources :boards, only: [:new, :create, :show, :update]
    resources :dices, only: [:new, :create]
    resources :card_decks, only: [:new, :create] do
      resources :cards, only: [:new, :create]
    end
    resources :pieces, only: [:new, :create]
    resources :tokens, only: [:new, :create]
    get "preview"
  end
end
