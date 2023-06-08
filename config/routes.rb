Rails.application.routes.draw do
  resources :archived_entries
  resources :entries do
    member do
      put :save_to_archive
    end
  end
  resources :feeds do
    member do
      post :entry_update
    end
  end

  put 'feeds/:feed_id/entries/:entry_id/archived', to: 'feeds#archived', as: 'feed_archived'
  # resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'
end
