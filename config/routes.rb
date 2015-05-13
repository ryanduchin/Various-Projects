Rails.application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, only: [:new]
  end
  resources :cat_rental_requests, only: [:create, :edit, :update, :show] do
    patch 'approve', on: :member
    patch 'deny', on: :member
  end
end
