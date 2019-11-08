Rails.application.routes.draw do
  resources :companies do
    patch :apply, on: :member
  end
  
  devise_for :users, path: 'users', controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions", registrations: 'admins/registrations' }

  get 'admin_home' => "companies#home"

  devise_scope :user do
    authenticated :user do
      root to: 'users/registrations#edit', as: :authenticated_root
    end
  
    unauthenticated do
      root to: 'users/registrations#index', as: :unauthenticated_root
    end
  end

  # Setting up two devise scopes did not work, move them to the after_sign_in methods inside the controller

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
