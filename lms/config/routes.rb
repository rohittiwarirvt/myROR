Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {sign_in:'login', sign_out: 'logout', sign_up:'register', edit:'settings'}
  root to: 'application#home'

  resources :courses

  get '/home', to: 'application#home', as: 'home'
  get '/secret', to: 'application#secret', as: 'secret'
  get '/about', to: 'application#about', as: 'about'
  get '/contact', to: 'application#contact', as: 'contact'
end
