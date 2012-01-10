class SmsController < ApplicationController
  def receive
    userNum = convertPhone(params[:From])
    restaurantNum = convertPhone(params[:To])
    user = User.find_by_phone(userNum)
    restaurant = Restaurant.find_by_smsNum(restaurantNum)
    body = params[:Body]
    
    if user.nil?
      @message = "Please Subscribe online first"
    elsif body.downcase.include?("stop")
      RestaurantUser.where(:user => user, :restaurant => restaurant).update_attribute :sms,false
      @message = "You've been successfully unsubscribed from deals from #{restaurant.name}. You can resubscribe at #{restaurant.subdomain}.simplebanana.com"
    elsif !user.phone_confirmed
      logger.debug "entered phone confirmed if"
      user.phone_confirmed = true
      user.save
      @message = "You've successfully confirmed your number! Look forward to deals from #{restaurant.name}"
    elsif body.downcase.include?("buy")
      
      transaction = Transaction.create_from_restaurant_user(user, restaurant)
      
      if transaction.valid?
        @message = "Thanks for buying it. Here is your redemption code: #{transaction.deal_code}"
      else
        @message = "transaction didn't work"
      end
      
      #deal = restaurant.current_deal  
      #if deal.nil?
     #   @message = "#{restaurant} does not have any current deals"
     #   render "sms_response" and return
     # end
      
     # if deal.sold_out?
     #   @message = "The current deal from #{restaurant} is sold out. Sorry."
     #   render "sms_response" and return
     # end

      #braintreeSuccessful = true

#      if !braintreeSuccessful
#        @message = "Your transaction was unsuccessful. Please update billing information"
#        render "sms_response" and return
#      end
    else
      @message = "Something went wrong"  
    end

    render "sms_response.xml.erb"
    
  end

end
