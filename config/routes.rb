Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :users, only: [:show, :edit, :update] do
    get "all"
  end
  resources :games do
    resources :boards, only: [:new, :create, :show, :update, :destroy]
    resources :dices, only: [:new, :create, :show, :update, :destroy ]
    resources :card_decks, only: [:new, :create, :show, :update, :destroy] do
      resources :cards, only: [:new, :create, :show, :update, :destroy]
    end
    resources :pieces, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :tokens, only: [:new, :create, :show, :edit, :update, :destroy]
    get "preview"
    resources :clones, only: [:new, :create, :show] do
      resources :cboards, only: [:create, :show, :update, :destroy]
      resources :cdices, only: [:create, :show, :update, :destroy ]
      resources :ccard_decks, only: [:create, :show, :update, :destroy] do
        resources :ccards, only: [:create, :show, :update, :destroy]
      end
      resources :cpieces, only: [:create, :show, :update, :destroy]
      resources :ctokens, only: [:create, :show, :update, :destroy]
    end
  end
  resources :gamerooms, only: [:new, :create, :show, :update] do
    resources :messages, only: :create
  end
end
