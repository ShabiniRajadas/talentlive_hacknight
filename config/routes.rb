Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#login'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
    resources :home do
      member do
        get 'participate_event'
        get 'profile'
        patch 'profile_create'
        get 'my_events', as: :my_events
        get 'event_details', as: :event_details
      end
  
      collection do
        get 'login'
        post 'new'
        get 'index', as: :landing
        get 'about_us', as: :about_us
        get 'upcoming'
        get 'ongoing'
        get 'results'
      end
    end

    namespace :admin do
      resources :homes do
        member do
          get 'edit'
          post 'update'
          get 'change_status'
          get 'audition'
          delete 'destroy', as: :destroy
        end

        collection do
          get 'events'
          post 'create_event'
          get 'save_json_data'
        end
      end
    end
    match 'admin/register_hangout',  to: 'admin/homes#save_json_data', via: :get
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
