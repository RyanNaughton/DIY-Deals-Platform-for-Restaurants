class TransactionsController < ApplicationController
  before_filter :ensure_logged_in, :only => :create

  def create
    @transaction = Transaction.create_from_restaurant_user current_user, current_restaurant
    render "buy.js.coffee"
  end

  private

  def ensure_logged_in
    if !logged_in?
      logger.debug("NOT LOGGED IN")
      return render(:text => "error")
    end
  end

end
