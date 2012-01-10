module ApplicationHelper

  def current_restaurant
    Restaurant.find_by_subdomain(request.subdomain)
  end

  def current_deal
    current_restaurant && current_restaurant.current_deal
  end

  def convertPhone(phone)
    phone.gsub!(/\D/, '').gsub(/1(?=\d{10})/,'')
  end
end
