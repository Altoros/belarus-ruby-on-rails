BelarusRubyOnRails::Application.routes.draw do
  resources :participants, :only => [:new, :create]
  get 'event/registration/thanks', :to => 'participants#thanks', :as => 'meetup/registration/thanks'
  delete 'participants/destroy', :to => "participants#destroy", :as => 'participants/destroy'
  get 'participants/accept', :to => "participants#accept", :as => 'participants/accept'
  get 'participants/decline', :to => "participants#decline", :as => 'participants/decline'

  resources :articles, :only => [:index, :show] do
    resources :comments, :only => [ :create, :edit, :update, :destroy ], :shallow => true do
      resource :comments, :only => :new
    end
  end

  resources :aggregated_articles, :only => [:index, :show], :path => '/news/'
  resources :profiles
  resources :profiles do
    delete 'avatar' => 'profiles#delete_avatar', :on => :member
  end

  get 'page/:permalink', :to => 'static_pages#show', :as => 'static_page'

  devise_for :users, :controllers => { :confirmations => "confirmations", :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" } do
    scope "/users/" do
      get 'sign_in', :to => "devise/sessions#new", :as => 'login'
      post 'sign_in', :to => "devise/sessions#create", :as => 'login'
      delete 'sign_out', :to => "devise/sessions#destroy", :as => 'logout'
      get 'auth/:provider', :to => 'omniauth#passthru'
      get ':id/reset_password', :to => 'users#reset_password', :as => 'user_reset_password'
    end
  end

  resources :users, :only => [:new, :create], :path => '/users/omniauth/'

  namespace :admin do
    resources :users, :except => [:create] do
      post '/' => 'users#index', :on => :collection
    end
    resource :message
    resource :dashboard, :only => :show
    resources :articles, :except => [:show]
    resources :static_pages, :except => [:show]
    resources :aggregated_articles, :only => [:index, :destroy], :path => '/news/'
    resources :aggregator_configurations do
      collection do
        get 'fetch'
      end
    end
    root :to => 'dashboards#show'
    resources :meetups do
      put 'cancel' => 'meetups#cancel'
    end
    resources :twitter_blocks
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
  #       current_news 'toggle'
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
  root :to => 'articles#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'

  get ':id', :to => 'articles#show'

end
