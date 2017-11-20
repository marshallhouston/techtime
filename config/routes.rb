Rails.application.routes.draw do
  root to: "welcome#index"

  # resources :cart, only: [:create]
  post 'cart', to: 'cart#create', as: :cart_index
  # resources :freelancers, only: [:index, :show]
  get 'freelancers', to: 'freelancers#index', as: :freelancers
  get 'freelancers/:id', to: 'freelancers#show', as: :freelancer

  # resources :categories, only: [:index]
  get 'categories', to: 'categories#index', as: :categories

  # resources :users, only: [:new, :create, :show]
  get 'users/new', to: 'users#new', as: :new_user
  post 'users', to: 'users#create', as: :users
  resources :orders, only: [:index, :show, :create]

  namespace :admin do
    resources :users, only: [:edit, :update, :show]
    resources :freelancers, only: [:new, :create, :index, :edit, :update]

    resources :orders, only: [:show]
    get 'dashboard', to: 'orders#index'
    patch 'dashboard', to: 'orders#update'
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'dashboard', to: 'users#show', as: :user
  get 'logout', to: 'sessions#destroy'

  get 'cart', to: 'cart#show'
  patch 'cart', to: 'cart#update'
  get ':slug', to: 'categories#show' # as: :category to allow category_path(category.slug) to be used
  delete 'cart', to: 'cart#destroy'



end

# ORIGINAL ROUTES

# Rails.application.routes.draw do
#   root to: "welcome#index"
#
#   resources :cart, only: [:create]
#   resources :freelancers, only: [:index, :show]
#   resources :categories, only: [:index]
#   resources :users, only: [:new, :create, :show]
#   resources :orders, only: [:index, :show, :create]
#
#   namespace :admin do
#     resources :users, only: [:edit, :update, :show]
#     resources :freelancers, only: [:new, :create, :index, :edit, :update]
#
#     resources :orders, only: [:show]
#     get '/dashboard', to: 'orders#index'
#     patch '/dashboard', to: 'orders#update'
#   end
#
#   get '/login', to: 'sessions#new'
#   post '/login', to: 'sessions#create'
#   get '/dashboard', to: 'users#show'
#   get '/logout', to: 'sessions#destroy'
#
#   get '/cart', to: 'cart#show'
#   patch '/cart', to: 'cart#update'
#   get '/:slug', to: 'categories#show'
#   delete '/cart', to: 'cart#destroy'
#
# end
