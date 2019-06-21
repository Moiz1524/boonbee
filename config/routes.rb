Rails.application.routes.draw do
  get '/dashboard',to: "user_panel#index", as: :user_panel
  get '/profile',to: "user_panel#profile", as: :myprofile

  get 'admin_panel',to: 'admin_panel#index',as: :admin_panel
  get 'admin_panel/users',as: :admin_users
  get 'admin_panel/all_campaigns', to: 'admin_panel#all_campaigns', as: :all_campaigns

  devise_for :users,:controllers => { sessions: 'users/sessions',registrations: 'users/registrations',passwords: 'users/passwords' }
  root 'home#home'
  get 'preview_receiver', to: 'donations#preview_receiver', as: :preview_receiver
  get 'admin', to: 'home#admin', as: :admin
  get '/invoices/:id', to: 'user_panel#view_invoice', as: :view_invoice
  resources :users
  get 'dashboard/test', to: 'user_panel#stripe_connect_handler', as: :stripe_connect

  resources :campaigns

  get 'campaigns/:id/campaign_funds', to: 'campaigns#campaign_funds', as: :campaign_funds

  resources :donations

end
