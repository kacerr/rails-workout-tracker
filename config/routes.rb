WorkoutTracker::Application.routes.draw do
  resources :measurements
  resources :excercises
  resources :workouts
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :messages

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'home#index'

  get 'welcome' => 'home#index', as: :welcome

  get 'signup' => 'users#new', as: :signup
  get 'signin' => 'sessions#new', as: :signin
  get 'reset-password' => 'sessions#reset_password', as: :reset_password
  post 'reset-password' => 'sessions#process_reset_password'
  get 'reset-password-finish/:token' => 'sessions#reset_password_finish', as: :reset_password_finish
  post 'reset-password-finish/:token' => 'sessions#reset_password_finish_save'

  get 'toggleown' => 'sessions#toggle_own', as: :toggleown
  delete 'signout' => 'sessions#destroy', as: :signout

  # user to user interaction
  get 'befriend/:id' => 'users#befriend', as: :befriend
  get 'rejectfriendship/:from_id/:to_id' => 'friendships#reject', as: :reject_friendship
  get 'acceptfriendship/:from_id/:to_id' => 'friendships#accept', as: :accept_friendship

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
