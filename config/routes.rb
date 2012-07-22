Oa::Application.routes.draw do

  resources :uploads
  resources :groups

  devise_scope :user do
    get "/users/sign_out", :to => "devise/sessions#destroy"
  end
  devise_for :users, :controllers => {:registrations => "registrations"} , :path_prefix => 'devise'
  resources :users

  root :to => 'home#main'
  # root :to => 'uploads/index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
end
