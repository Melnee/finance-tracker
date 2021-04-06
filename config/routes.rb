Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'  
  get "my_portfolio", to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  get 'user_stocks', to: 'user_stocks#create'
  get '/user_stock_delete/:id', to: 'user_stocks#destroy', as: 'user_stocks_delete'
end
