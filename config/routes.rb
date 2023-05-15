Rails.application.routes.draw do
  get 'welcome/index'
  resources :entries
  resources :feeds
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'posts#index'
end
