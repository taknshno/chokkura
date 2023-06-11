Rails.application.routes.draw do
  root to: 'spots#index'

  resources :spots do
    collection do
      post :confirm
    end
  end
end
