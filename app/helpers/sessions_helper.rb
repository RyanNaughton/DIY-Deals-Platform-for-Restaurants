module SessionsHelper

  def logged_in?
    current_user.present?
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def is_admin?
    logged_in? && current_restaurant && current_user == current_restaurant.myOwner
  end

end
