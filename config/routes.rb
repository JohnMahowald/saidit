Rails.application.routes.draw do
  root to: 'users#new'
  
  resources :users
  resource :session, only: [:create, :destroy, :new]
  
  resources :subs do
    resources :posts, only: [:new]
  end
  
  resources :posts, except: [:new, :index]
  
end
