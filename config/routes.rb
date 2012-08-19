Oa::Application.routes.draw do

  resources :unpaid_debts do
    member do
        get 'verify'
    end
  end
  resources :reimbursements do
    member do
        get 'verify'
    end
  end

  resources :in_comes
  resources :transfers
  resources :expenditures

  resources :acceptances
  resources :bank_accounts

  resources :tasks
  resources :deliveries

  resources :out_stores
  resources :in_stores

  resources :attendances do
    collection do
      post 'create_all'
      get 'personal'
    end
  end

  resources :messages do
     collection do
        get "get_unread"
     end
  end

  resources :attaches
  resources :announcements

  resources :notes

  resources :supl_contracts

  resources :suppliers

  resources :groups

  devise_scope :user do
    get "/users/sign_out", :to => "devise/sessions#destroy"
  end
  devise_for :users, :controllers => {:registrations=>"registrations",:sessions=>'sessions'} ,:path_prefix => 'devise'
  resources :users

  root :to => 'home#main'

  match ':controller(/:action(/:id))(.:format)'
end
