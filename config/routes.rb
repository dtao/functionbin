FunctionBin::Application.routes.draw do
  # Root route
  root 'home#index'

  # Regular routes
  match '/login'    => 'home#login',    :via => [:get, :post]
  match '/register' => 'home#register', :via => [:get, :post]
  get '/logout'     => 'home#logout'

  # Named routes
  get 'functions/:id/implement' => 'implementations#new', :as => :implement_function
  get 'implementations/:id/upvote' => 'implementations#upvote', :as => :upvote_implementation

  # Resource routes
  resources :users
  resources :functions
  resources :implementations

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
