Oa::Application.routes.draw do

  resources :messages do
     collection do
        get "get_unread"
     end
  end
  get '/messages/archive/:id' , :to => 'messages#archive'

  resources :notes
  get '/notes/archive/:id' , :to => 'notes#archive'

  resources :uploads

  resources :groups
  get '/groups/archive/:id' , :to => 'groups#archive'

  devise_scope :user do
    get "/users/sign_out", :to => "devise/sessions#destroy"
  end
  devise_for :users, :controllers => {:registrations => "registrations"} , :path_prefix => 'devise'
  resources :users
  get '/users/archive/:id' , :to => 'users#archive'

  root :to => 'home#main'

  match ':controller(/:action(/:id))(.:format)'
end
