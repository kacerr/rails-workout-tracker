WorkoutTracker::Application.routes.draw do
  resources :workout_unit_types

  resources :workout_units

  resources :user_measurements

  resources :articles

  resources :profiles

  resources :measurements
  resources :excercises
  resources :workouts
  resources :users
  resources :groups
  resources :sessions, only: [:new, :create, :destroy]
  resources :messages

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'home#index'

  get 'welcome' => 'home#index', as: :welcome

  get 'signup' => 'users#new', as: :signup
  get 'signin' => 'sessions#new', as: :signin
  get 'auth/:provider/callback' => 'sessions#create'
  get 'reset-password' => 'sessions#reset_password', as: :reset_password
  post 'reset-password' => 'sessions#process_reset_password'
  get 'reset-password-finish/:token' => 'sessions#reset_password_finish', as: :reset_password_finish
  post 'reset-password-finish/:token' => 'sessions#reset_password_finish_save'

  get 'toggleown' => 'sessions#toggle_own', as: :toggleown
  delete 'signout' => 'sessions#destroy', as: :signout
  #get 'signout' => 'sessions#destroy', as: :signout

  # user profile
  get 'user/:id/profile' => 'users#show_profile', as: :view_profile

  # user to user interaction
  get 'befriend/:id' => 'users#befriend', as: :befriend
  get 'rejectfriendship/:from_id/:to_id' => 'friendships#reject', as: :reject_friendship
  get 'acceptfriendship/:from_id/:to_id' => 'friendships#accept', as: :accept_friendship

  # groups and user grouping
  get 'user/my-groups' => 'users#mygroups', as: :mygroups
  post 'user/my-groups' => 'users#mygroups_save'
  ## group details & members
  get 'user/my-group-edit/:id' => 'users#mygroup_edit', as: :mygroup_edit
  get 'user/groups-i-am-in' => 'users#groups_i_am_in', as: :groups_i_am_in
  ## group add / remove members
  get 'user/:id/remove-from-group/:group_id' => 'users#remove_user_from_group'
  get 'user/:id/add-to-group/:group_id' => 'users#add_user_to_group'
  get 'user/remove-me-from-group/:id' => 'users#remove_me_from_group', as: :remove_me_from_group
  ## visibility of events from this group in stream
  get 'user/hide-group-from-stream/:id' => 'users#hide_group_from_stream', as: :hide_group_from_stream
  get 'user/show-group-in-stream/:id' => 'users#show_group_in_stream', as: :show_group_in_stream

  # join workout
  get 'workout/:id/join' => 'workouts#join', as: :join_workout

  # user measurements
  get 'my-measurements' => 'user_measurements#index', as: :my_measurements

  # inbox
  get 'inbox/:part' => 'messages#index', as: :inbox

  # workouts
  get 'workout-details/:id' => 'workouts#show_details', as: :workout_details


  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
