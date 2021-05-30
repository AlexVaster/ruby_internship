Rails.application.routes.draw do
  resources :entries
  resource :login, only: %i[show create destroy]

  get 'check', to: 'entries#check'
end
