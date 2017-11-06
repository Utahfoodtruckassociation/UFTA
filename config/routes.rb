Rails.application.routes.draw do
  
  namespace :admin do
    resources :users
    resources :menus
    resources :trucks
    # resources :guest_users

    root to: "users#index"
  end

  resources :trucks
  post "create_event/:id", to:'trucks#create_event', as: 'create_event'
  get "new_event/:id", to:'trucks#new_event', as: 'new_event'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "our_company", to:'pages#our_company'

  root to: 'pages#home'

end
