class SessionsController < ApplicationController

  def create
    logger.debug "create"
    logger.debug session
    user = User.find_by_email(params[:email].downcase)
    session[:user_id] = user.id if user && user.authenticate(params[:password])
    @should_refresh_main = user.is_restaurant_owner?
    logger.debug session
    render "refresh_login.coffee.js"
  end

  def destroy
    logger.debug "destroy"
    logger.debug session
    @should_refresh_main = current_user.is_restaurant_owner?
    # reset_session
    session[:user_id] = nil
    logger.debug session
    render "refresh_login.coffee.js"
  end


end
