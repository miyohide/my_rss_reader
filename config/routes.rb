Rails.application.routes.draw do
  resources :archived_entries
  resources :entries
  resources :feeds do
    member do
      post :entry_update
    end
  end
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'
end
