Rails.application.routes.draw do

  resources :users, only: [:index, :create, :update, :show, :destroy] do
    resources :contacts, only: [:index]
    resources :comments, only: [:create, :update, :show, :destroy]
  end
  resources :contacts, only: [:create, :update, :show, :destroy] do
    resources :comments, only: [:create, :update, :show, :destroy]
  end

  resources :contact_shares, only: [:create, :destroy]
end
