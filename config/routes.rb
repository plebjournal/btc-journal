Rails.application.routes.draw do

  devise_for :users, sign_out_via: :post

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  #root_url = "/"
  root 'home#index'

  resources :user_settings
  resources :transactions
  resource :import_transactions do
    get :index
    post :upload
    post :create
  end
  get 'dashboard' => 'dashboard#index'
  get 'charts' => 'charts#index'

  namespace :api do
    get 'fiat-value' => 'fiat_value#index'
    get 'portfolio' => 'portfolio#index'
    get 'cost-basis' => 'cost_basis#index'
  end
end
