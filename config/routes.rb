Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show] do
        get "transactions", :to => "customers/transactions#index"
        get "invoices", :to => "customers/invoices#index"
      end
      resources :transactions, only: [:index, :show] do
        get "invoice", :to => "transactions/invoices#show"
      end
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end
end
