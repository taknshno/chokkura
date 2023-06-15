Rails.application.routes.draw do
  get 'users/show'
  devise_for :users

  root to: 'spots#index'

  resources :spots, only: [:index, :show] do
    collection do
      get :search
    end
  end

  resources :users, :only => [:show]

  namespace :admin do
    resources :spots, only: [:new, :create, :edit, :update, :destroy] do
      collection do
        post :confirm
      end
    end
    resources :tags, only: [:index, :new, :create, :edit, :update, :destroy] do
      collection do
        post :confirm
      end
    end
  end

  resources :favorites, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
