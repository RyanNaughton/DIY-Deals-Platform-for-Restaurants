class UsersController < ApplicationController
  require "stripe"

  def confirm_email
    @user = User.find_by_email_confirmation_code(params[:code]) 
  end

  def update
  end

  def forgot_password
  end
  
  def payment_info
    render '/users/payment_form'
  end

  def set_customer_payment
    # get the credit card details submitted by the form
    token = params[:stripeToken]
    user = current_user

    # set your secret key: remember to change this to your live secret key in production
    # see your keys here https://manage.stripe.com/account
    Stripe.api_key = "0BmqgHSlISJwMUvcdc8yHW5Mo9iUScSe"

    # create a Customer
    customer = Stripe::Customer.create(
      :card => token,
      :description => user.email
    )
    user.stripe_id = customer.id
    user.save

  end

end
