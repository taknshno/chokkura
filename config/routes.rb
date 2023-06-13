Rails.application.routes.draw do
  devise_for :users

  root to: 'spots#index'

  resources :spots, only: [:index, :show]

  namespace :admin do
    resources :spots, only: [:new, :create, :edit, :destroy] do
      collection do
        post :confirm
      end
    end
    resources :tags, only: [:index, :new, :create, :edit, :destroy] do
      collection do
        post :confirm
      end
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
