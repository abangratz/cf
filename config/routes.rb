Cf::Application.routes.draw do

  resources :subscriptions, :only => [:create, :update] do
    member do
      post :toggle_confirm
    end
  end

  resources :calendar_events

  resources :profiles, :except => [:destroy]

  resources :pages, :only => [:index, :show]

  resources :topics do
    member do
      get :sticky
      get :unsticky
      get :lock
      get :unlock
    end
    resources :replies
  end


  resources :forum_groups, :only => [:index] do
    resources :forums, :only => [:index, :show] do
      resources :topics, :only => [:new, :create]
    end
  end

  devise_for :users

  get "administration" => 'administration#index'
  get 'roster' => 'roster#show'
  post "administration/upload_guild_xml"

  resources :articles, :only => [:index, :show]

  devise_for :admins

  namespace :administration do
    resources :characters
    resources :users
    resources :articles
    resources :pages do
      collection do
        post :prioritize
      end
    end
    resources :forum_groups do
      collection do
        post :prioritize
      end
      resources :forums do
        collection do
          post :prioritize
        end
      end
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "articles#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
