Rails.application.routes.draw do
  resources :merchants, only: [:index] do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index, :show]
    resources :items, except: [:update]
  end

  patch '/merchants/:merchant_id/items', to: 'items#status_update'

  patch '/merchants/:merchant_id/items/:id', to: 'items#update'

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants
  end

end
