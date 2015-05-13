Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:create, :edit, :new, :update, :show] do
    patch 'approve' => 'cat_rental_requests#approve'
    patch 'deny' => 'cat_rental_requests#deny'
  end
end
