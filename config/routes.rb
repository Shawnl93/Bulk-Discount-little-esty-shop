Rails.application.routes.draw do
  resources :merchants, only: [:index] do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index]
    resources :items, only: [:index, :show, :edit]
  end

  patch '/merchants/:merchant_id/items/:id', to: 'items#update'

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants
  end

end
