Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy]
  resources :posts, except: [:index, :destroy] do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create, :show]

  root "subs#index"
end
