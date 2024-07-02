Rails.application.routes.draw do
  get 'admin/withdraw', to: 'admin_payment_withdraw#page'
  get 'admin/view/withdraw',to: 'admin_payment_withdraw#view_withdraw'
   get 'admin/view/withdraw/:id',to: 'admin_payment_withdraw#view_detail'
  #get 'admin_payment_withdraw/update_withdraw'
  #get 'admin_payment_withdraw/delete_withdraw'
  #get 'admin_payment_withdraw/edit_withdraw'
  post 'admin/withdraw/edit/:id',to: 'admin_payment_withdraw#edit_withdraw'
  post 'admin/withdraw/accept/:id',to: 'admin_payment_withdraw#accept_withdraw'
  
  
  
  get 'admin/deposit', to: 'admin_payment_deposit#page'
  get 'admin/view/deposit', to: 'admin_payment_deposit#view_deposit'
  #get 'admin_payment_deposit/update_deposit'
  #get 'admin_payment_deposit/delete_deposit'
  #get 'admin_payment_deposit/edit_deposit'
  #get 'admin_payment_deposit/cancel_deposit'
  
  
  
  get 'admin/user/:user_id', to: 'admin_user_detail#page'
post 'admin/user/update-password/:user_id', to: 'admin_user_detail#post_edit_user'
   get 'admin/view/:user_id',to: 'admin_user_detail#view_user'
   post 'admin/user/update-balance/:user_id', to: 'admin_user_detail#edit_user'
 # get 'admin_user_detail/edit_user'
  #get 'admin_user_detail/post_edit_user'
  
  
  get 'admin/users', to: 'admin_user#page'
  get 'admin/users/view_user', to: 'admin_user#view_user'
  #get 'admin_user/edit_user'
  post 'admin/users', to: 'admin_user#post_edit_user'
  
  get 'admin', to:'admin_home#page', as: 'admin'
  get 'admin/get_full', to:'admin_home#get_full'
  #get 'admin_home/searching_time'
  get 'admin/login', to: 'admin_login#page', as: 'admin_login'
  post 'admin/login', to: 'admin_login#login'
  get 'admin/logout', to: 'admin_login#destroy'
  get 'support', to: 'ticket#page'
  get 'support/get_ticket', to: 'ticket#get_ticket'
  post 'support/post_ticket', to: 'ticket#post_ticket'
  
  
  get 'get_info/info_user', to: 'get_info#info_user'
  
  
  
  get 'user', to: 'user_info#page'
  post 'user/change_password', to: 'user_info#change_password'
  
  #withdraw
  get 'withdraw', to: 'withdraw#page'
  post 'withdraw/with_request', to: 'withdraw#with_request'
  get 'withdraw/check', to: 'withdraw#check'
  
  #depsit
  get 'deposit', to: 'deposit#page'
  post 'deposit', to: 'deposit#deposit'
  post 'deposit/notify', to:'deposit#notify'
  #get 'deposit/success'
  #get 'deposit/fails'
  get 'deposit/check', to: 'deposit#check'
  
  
  
  get 'horseracing', to: 'horseracing#page'
  post 'horseracing/bet', to: 'horseracing#racing'
  get 'horseracing/result'
  
  
  get 'slot-game333', to: 'slot_game333#page'
  post 'slot-game333/spin', to: 'slot_game333#spin'
  get 'slot-game333/result', to: 'slot_game333#result'
  
  

  root 'pages#home'
  get 'dashboard/index'
  get 'login', to: 'login#new', as: 'new_login'
  post 'login', to: 'login#create'
  get 'logout', to: 'login#destroy'
  get 'register', to: 'registrations#new', as: 'new_registration'
  post 'register', to: 'registrations#create'
  #get 'info/deposit'
  #get 'info/withdraw'
  #get 'info/update_info'
  get 'user/get_info', to: 'user#get_info'
  
  get 'scratch-game', to: 'scratch_game#page'
  get 'scratch-game/result', to: 'scratch_game#result'
  post 'scratch-game/buy', to: 'scratch_game#buy', as: 'buy_scratch'
  get 'scratch-game/scratch', to: 'scratch_game#scratch'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
