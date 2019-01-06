Rails.application.routes.draw do
  resources :sessions, only:[:new, :create, :destroy]
  get'/tops',to:'tops#top'
  root 'tops#top'


  resources :blogs do
    collection do
      post:confirm
    end
  end

  resources :users do
    collection do
      post:confirm
    end
    member do
      get 'favorite'
    end

  end
  resources :favorites, only: [:create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
