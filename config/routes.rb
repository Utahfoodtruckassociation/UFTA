Rails.application.routes.draw do
  
  resources :trucks
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "/about", to:'pages#about'

  get "/contact", to:'pages#contact'

  root to: 'pages#home'

end
