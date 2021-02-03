Rails.application.routes.draw do
  get 'messages/create'
  get 'contacts/new'
  devise_for :users
  resources :projects
  resources :contacts, only: [:index, :new, :create] do
    member do
      get 'sent'
    end
  end
  post "pages/subscribe", to: "pages#subscribe"
  resources :messages, only: [:create, :new]
  resources :homepages, only: [:edit, :update]
  resources :photos, only: [:destroy]
  resources :updates
  root to: 'pages#home'
  get "about", to: "pages#about", as: "about"
  get "bronze", to: "projects#bronze", as: "bronze"
  get "scrap", to: "projects#scrap", as: "scrap"
  get "news", to: "updates#index", as: "news"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
