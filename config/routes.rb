Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/search',  to: 'properties#search'
  get    '/admin',   to: 'users#admin'
  resources :users do
    get :favorites, on: :member
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :properties do
    get  :interested_users, on: :member
    post :mark_as_sold,     on: :member
  end
  resources :wishlists,           only: [:create, :destroy]
  resources :comments,            only: [:create, :destroy]
end