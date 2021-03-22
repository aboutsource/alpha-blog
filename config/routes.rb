Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'search', to: 'pages#search'
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories
  get 'welcome', to: 'pages#welcome'
end
