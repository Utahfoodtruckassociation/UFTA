Rails.application.routes.draw do
  
  devise_for :users

  get "/trucks", to:'pages#trucks'

  get "/about", to:'pages#about'

  get "/contact", to:'pages#contact'

  root to: 'pages#home'

end