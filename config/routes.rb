ActionController::Routing::Routes.draw do |map|
  map.resources :events

  map.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :requirements => {:year => /d{4}/, :month => /d{1,2}/}, :year => nil, :month => nil
  map.new_contact '/contact/new', :controller => 'contact', :action => 'new', :conditions => { :method => :get }
  map.contact '/contact', :controller => 'contact', :action => 'new', :conditions => { :method => :get }
  map.contact '/contact', :controller => 'contact', :action => 'create', :conditions => { :method => :post }
  map.resources :photos

  map.resources :galleries

  map.lost_password '/lost_password', :controller => 'users', :action => 'lost_password'
  map.reset_password 'reset_password/:reset_code', :controller => 'users', :action => 'reset_password'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users

  map.resource :session
  
  map.resource :jqueryfiletree

  # Savage beast routes BEGIN
 map.resources :posts, :name_prefix => 'all_', :collection => { :search => :get }
	map.resources :forums, :topics, :posts, :monitorship

  %w(forum).each do |attr|
    map.resources :posts, :name_prefix => "#{attr}_", :path_prefix => "/#{attr.pluralize}/:#{attr}_id"
  end
  
  map.resources :forums do |forum|
    forum.resources :topics do |topic|
      topic.resources :posts
      topic.resource :monitorship, :controller => :monitorships
    end
  end
  # Savage beast routes END

  map.roster  '/roster', :controller => 'brothers', :action => 'index', :conditions => { :method => :get }
  map.roster_new  'roster/new', :controller => 'brothers', :action => 'new', :conditions => { :method => :get }
  map.roster_new  'roster/new', :controller => 'brothers', :action => 'create', :conditions => { :method => :post }
  map.roster_show  'roster/:id', :controller => 'brothers', :action => 'show', :conditions => { :method => :get }
  map.roster_edit  'roster/edit/:id', :controller => 'brothers', :action => 'edit', :conditions => { :method => :get }
  map.roster_update  'roster/:id', :controller => 'brothers', :action => 'update', :conditions => { :method => :put }
  
  map.resources :brothers

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home", :action => 'index'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect 'repository/:filename.:format', :controller => 'repository', :action => 'show', :conditions => { :method => :get }
  #map.connect 'roster/:id', :controller => 'brothers', :action => 'show', :conditions => { :method => :get }
end
