Rails.application.routes.draw do
  
  resources :trucks
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "our_company", to:'pages#our_company'

  root to: 'pages#home'

end
