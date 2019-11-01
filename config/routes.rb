Rails.application.routes.draw do
  resources :companies
  devise_for :users, path: 'users', controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions", registrations: 'users/registrations' }

  devise_scope :user do
    authenticated :user do
      root 'users/registrations#edit', as: :authenticated_root
    end
  
    unauthenticated do
      root 'users/registrations#index', as: :unauthenticated_root
    end
  end

  devise_scope :admin do
    authenticated :admin do
      root 'companies#new', as: :admin_authenticated_root
    end
  
    unauthenticated do
      root 'users/registrations#index', as: :admin_unauthenticated_root
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
