Rails.application.routes.draw do
  #namespace :admin do
    #root 'welcome#index'
  #end
  resources :users
  resources :orders do
    get 'first', on: :collection
    get 'check', on: :collection
    get 'approve', on: :member
  end
  #resources :orders
  #get 'hello/index'

  #get 'calc', to: 'orders#calc'
  resource :login, only: [:show, :create, :destroy]

  # get '/check', to: 'orders#check'
  #resource :check

  #root 'orders#calc'
end
