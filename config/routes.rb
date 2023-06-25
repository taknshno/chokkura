Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/show'
  end
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  root to: 'spots#index'

  resources :spots, only: [:index, :show] do
    collection do
      get :search
    end
  end

  resources :users, :only => [:show]

  resources :admin, :only => [:index]

  namespace :admin do
    resources :spots, only: [:index, :new, :create, :edit, :update, :destroy] do
      collection do
        post :confirm
      end
    end
    resources :tags, only: [:index, :new, :create, :edit, :update, :destroy] do
      collection do
        post :confirm
      end
    end
    resources :users, :only => [:index, :show, :new, :edit] do
      member do
        get :control
      end
    end
  end

  resources :favorites, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
