Oa::Application.routes.draw do

  resources :attendances

  resources :announcements

  resources :messages do
     collection do
        get "get_unread"
     end
  end
  get '/messages/archive/:id' , :to => 'messages#archive'

  resources :attaches
  resources :announcements

  resources :notes
  get '/notes/archive/:id' , :to => 'notes#archive'

  resources :supl_contracts
  get '/supl_contracts/archive/:id' , :to => 'supl_contracts#archive'

  resources :suppliers
  get '/suppliers/archive/:id' , :to => 'suppliers#archive'

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
