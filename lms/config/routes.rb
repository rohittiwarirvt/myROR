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
    resources :course_sections, except: [:index, :show] do
      resources :resources do
        put :update_details
      end
      resources :videos, controller: 'resources', type: 'Video' do
        get :content, on: :new, action: :new, content: true
      end
      resources :presentations do
        resources :slides do
          member do
            put :update_settings
            put :update_ppt_title
            put :delete_bg_img
            put :update_title
            put :update_contents
            delete :destroy_column
            post :slide_clone
            put :apply_settings
          end
        end
      end
      resources :assessments
      resources :custom_contents
      resources :interactive_slides do
        resources :interactive_slides_informations do
          member do
            put :delete_slide_img
          end
        end
      end
    end
    resources :resources
    resources :evaluation_questions, except: [:show, :new]
  end
  resources :categories
  resources :certificates
  get '/home', to: 'application#home', as: 'home'
  get '/secret', to: 'application#secret', as: 'secret'
  get '/about', to: 'application#about', as: 'about'
  get '/contact', to: 'application#contact', as: 'contact'
end
