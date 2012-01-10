RestaurantDeals::Application.routes.draw do

  post "login" => "sessions#create"
  post "logout" => "sessions#destroy"

  post "sms" => "sms#receive"
  post "deals/create"
  post "buyit" => "transactions#create"

  get "quantity" => "deals#quantity"
  get "/update_time_remaining" => "deals#time_remaining"

  post "users/create"
  get "users/update"
  get 'confirm_email' => 'users#confirm_email', :as => :confirm_email
	get "admin" => 'restaurants#admin'

  constraints(Subdomain) do
    match '/' => 'restaurants#index'
  end

  match '/auth/twitter/callback', to: 'restaurants#set_twitter'
  get '/twitter_display' => 'restaurants#twitter'
  get '/twitter_unlink' => 'restaurants#twitter_destroy'
  get '/payment_form' => 'users#payment_info'
  post '/payment_form' => 'users#set_customer_payment'
  get '/purchased_deals' => 'restaurants#purchased_deals'

end
