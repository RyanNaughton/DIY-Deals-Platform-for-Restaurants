class RestaurantsController < ApplicationController
  before_filter :require_admin, :only => :admin

  def index
  end

  def admin
  end

  def twitter
    render :partial => 'restaurants/twitter'
  end

  def twitter_destroy
    restaurant = current_restaurant
    restaurant.remove_twitter
    redirect_to '/'
  end

  def set_twitter
      restaurant = current_user.myRestaurant
      data = request.env["omniauth.auth"]
      restaurant.twitter_handle = data['info']['nickname']
      restaurant.twitter_token = data['credentials']['token']
      restaurant.twitter_secret = data['credentials']['secret']
      restaurant.save
      redirect_to '/'
  end

  def purchased_deals
    if current_deal
       render :json => (current_deal.transactions.reduce({}) do |hash, transaction|
        hash[dom_id(transaction.deal_code)] = transaction.user.full_name
        hash
      end)
    else
      render :json => {}
    end
  end

  private

  def require_admin
    if not is_admin?
      redirect_to "/", :notice => "Please sign in to manage your restaurant account"
    end
  end

end
