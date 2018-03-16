Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "most_revenue", :to => "intelligence#index"
        get "most_items", :to => "intelligence#index"
        get "revenue", :to => "intelligence#index"
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
      namespace :customers do
        get "find_all", :to => "customers#index"
        get "find", :to => "customers#show"
        get "random", :to => "customers#show"
        get "/", :to => "customers#index"
        get "/:id", :to => "customers#show"
      end
      namespace :items do
        get "most_revenue", :to => "intelligence#index"
        get "most_items", :to => "intelligence#index"
        get "find_all", :to => "items#index"
        get "find", :to => "items#show"
        get "random", :to => "items#show"
        get "/", :to => "items#index"
        get "/:id", :to => "items#show"
      end
      namespace :invoice_items do
        get "find_all", :to => "invoice_items#index"
        get "find", :to => "invoice_items#show"
        get "random", :to => "invoice_items#show"
        get "/", :to => "invoice_items#index"
        get "/:id", :to => "invoice_items#show"
      end
      namespace :transactions do
        get "find_all", :to => "transactions#index"
        get "find", :to => "transactions#show"
        get "random", :to => "transactions#show"
        get "/", :to => "transactions#index"
        get "/:id", :to => "transactions#show"
      end
      resources :merchants, only: [] do
        get "invoices", :to => "merchants/invoices#index"
        get "items", :to => "merchants/items#index"
        get "favorite_customer", :to => "merchants/intelligence#show"
        get "revenue", :to => "transactions/intelligence#show"
        get "customers_with_pending_invoices", :to => "merchants/intelligence#show"
      end
      resources :customers, only: [] do
        get "transactions", :to => "customers/transactions#index"
        get "invoices", :to => "customers/invoices#index"
        get "favorite_merchant", :to => "customers/intelligence#show"
      end
      resources :transactions, only: [] do
        get "invoice", :to => "transactions/invoices#show"
      end
      resources :items, only: [] do
        get "invoice_items", :to => "items/invoice_items#index"
        get "merchant", :to => "items/merchants#show"
        get "best_day", :to => "items/intelligence#show"
      end
      resources :invoice_items, only: [] do
        get "invoice", :to => "invoice_items/invoices#show"
        get "item", :to => "invoice_items/items#show"
      end
      resources :invoices, only: [] do
        get "transactions", :to => "invoices/transactions#index"
        get "invoice_items", :to => "invoices/invoice_items#index"
        get "items", :to => "invoices/items#index"
        get "customer", :to => "invoices/customers#show"
        get "merchant", :to => "invoices/merchants#show"
      end
    end
  end
end
