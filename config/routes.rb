Rails.application.routes.draw do
  root to: 'spots#index'

  resources :spots do
    collection do
      post :confirm
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
