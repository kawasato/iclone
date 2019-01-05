Rails.application.routes.draw do
  resources :sessions, only:[:new, :create, :destroy]

  resources :blogs do
    collection do
      post:confirm
    end
  end
  resources :users, only: [:new, :edit, :create, :show]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
