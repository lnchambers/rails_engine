Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "most_revenue", :to => "intelligence#index"
        get "find_all", :to => "merchants#index"
        get "find", :to => "merchants#show"
        get "random", :to => "merchants#show"
        get "/", :to => "merchants#index"
        get "/:id", :to => "merchants#show"
      end
      namespace :invoices do
        get "find_all", :to => "invoices#index"
        get "find", :to => "invoices#show"
        get "random", :to => "invoices#show"
        get "/", :to => "invoices#index"
        get "/:id", :to => "invoices#show"
      end
      resources :merchants, only: [] do
        get "invoices", :to => "merchants/invoices#index"
        get "items", :to => "merchants/items#index"
        get "favorite_customer", :to => "merchants/intelligence#show"
      end
      resources :customers, only: [:index, :show] do
        get "transactions", :to => "customers/transactions#index"
        get "invoices", :to => "customers/invoices#index"
      end
      resources :transactions, only: [:index, :show] do
        get "invoice", :to => "transactions/invoices#show"
      end
      resources :items, only: [:index, :show]
      resources :invoices, only: [] do
        get "transactions", :to => "invoices/transactions#index"
        get "invoice_items", :to => "invoices/invoice_items#index"
        get "items", :to => "invoices/items#index"
        get "customer", :to => "invoices/customers#show"
        get "merchant", :to => "invoices/merchants#show"
      end
      resources :invoice_items, only: [:index, :show]
    end
  end
end
