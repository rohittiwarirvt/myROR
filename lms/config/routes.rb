Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {sign_in:'login', sign_out: 'logout', sign_up:'register', edit:'settings'}
  root to: 'application#home'

  resources :courses
  resources :versions do
    member do
      get :editable
      put :publish
      get :preview
      get :syllabus, action: :show, version_view: 'Syllabus'
    end
  end

  get '/home', to: 'application#home', as: 'home'
  get '/secret', to: 'application#secret', as: 'secret'
  get '/about', to: 'application#about', as: 'about'
  get '/contact', to: 'application#contact', as: 'contact'
end
