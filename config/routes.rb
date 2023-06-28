Rails.application.routes.draw do
  root to: 'top#index'

  namespace :admin do
    get 'users/index'
    get 'users/show'
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

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

  devise_scope :user do
    post 'users/common_guest_sign_in', to: 'users/sessions#common_guest_sign_in'
    post 'users/admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
