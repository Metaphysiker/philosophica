Rails.application.routes.draw do
  get 'calendar/show'

  #devise_for :users
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }, :path_prefix => 'my'
  resources :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :scripts do

    member do
      get 'fileContent'
    end
  end

  get 'user/' => 'users#fileContent', as: 'fileContent'

  # You can have the root of your site routed with "root"
  root 'static_pages#index'
  get 'adminpanel' => 'users#adminpanel', as: 'adminpanel'
  get 'user/:username/' => 'users#show', as: 'profile'
  get 'blog/:url/' => 'blogs#show', as: 'philblog'

  post '/confirm/:name' => 'users#confirm', as: 'confirm'

  get 'search/:query' => 'search#search', as: 'search'

  get 'events/publishpanel', to: 'events#publishpanel', as: "publishpanel"
  get 'static_pages/stackoverflow', to: 'static_pages#st', as: "stackoverflow"
  get 'static_pages/kalender', to: 'static_pages#kalender', as: 'kalender'
  get 'user/:username/', to: 'users#show', as: 'userkalender'
  get 'static_pages/forschung', to: 'static_pages#forschung', as: 'forschung'
  get 'static_pages/ausbildung', to: 'static_pages#ausbildung', as: 'ausbildung'
  get 'static_pages/themen', to: 'static_pages#themen', as: 'themen'

  resources :tags, only: [:index, :show]

  # Events

  resource :calendar, only: [:show], controller: :calendar
  resources :newsletters
  resources :events do
    resources :date_events
  end
  resources :blogs do
    resources :blogposts
  end
  resources :infos

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
