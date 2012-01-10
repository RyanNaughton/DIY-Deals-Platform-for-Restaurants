class DealsController < ApplicationController

  def create
  	if current_user == current_restaurant.myOwner
	  	@deal = Deal.new
		  @deal.restaurant = current_restaurant
		  @deal.quantity = params[:quantity]
		  @deal.discounted_price = (params[:discounted_price].to_f*100).to_i
		  @deal.original_price = (params[:original_price].to_f*100).to_i
		  day = (Time.now + (params[:day]=="tonight" ? 0:1).days).strftime("%d/%m/%Y ")
		  @deal.start_on = day + params[:start_time] + " CST"
		  @deal.end_on =  day +params[:end_time] + " CST"
      if @deal.save
        Resque.enqueue(DealMessenger, @deal.id)
        render "refresh_deal.js.coffee"
      else
          format.json { render :json => @deal.errors, :status => :unprocessable_entity }
      end
	  end
  end

  def quantity
    quantity = (current_deal && current_deal.quantity_remaining) || 0
    respond_to do |format|
      format.json { render :json => { quantity: quantity } }
    end
  end

  def time_remaining
    render "update_time_remaining.js.coffee"
  end

end
