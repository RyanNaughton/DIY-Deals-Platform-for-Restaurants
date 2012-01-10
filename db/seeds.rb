# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all

#User.create :first_name => "Eric",
#            :last_name => "L",
#            :email => "eric@simplebanana.com",
#            :password => "cookies", :password_confirmation => "cookies",
#            :phone => "8572311427",
#            :phone_confirmed => true,
#            :email_confirmed => true

User.create :first_name => "Andrew",
            :last_name => "M",
            :email => "andrew@simplebanana.com",
            :password => "cookies", :password_confirmation => "cookies",
            :phone => "3124769626",
            :phone_confirmed => true,
            :email_confirmed => true

User.create :first_name => "Neal",
            :last_name => "SG",
            :email => "Neal@simplebanana.com",
            :password => "cookies", :password_confirmation => "cookies"

Restaurant.destroy_all

Restaurant.create :name => "Code Academy Cafe",
                  :phone => "7577737480",
                  :smsNum => "3122573773",
                  :subdomain => "cacafe",
                  :myOwner => User.last

DealCode.destroy_all

DealTemplate.destroy_all
DealTemplate.create :text_description => '"#{deal_discounted_price} for #{deal_original_price} at #{restaurant.name} #{deal_day_and_time_range}"',
:html_description => '"<h1><span class=\"highlight\">#{deal_discounted_price}</span> for <span class=\"highlight\">#{deal_original_price}</span> #{deal_day_and_time_range}. Only <span class=\"highlight\">#{quantity}</span> deals available!</h1>"'

Deal.destroy_all
Deal.create :discounted_price => 1500,
            :original_price => 2500,
            :start_on => Time.now - 3.hours,
            :end_on => Time.now + 1.minutes,
            :restaurant => Restaurant.last,
            :deal_template => DealTemplate.first,
            :quantity => 5

Deal.create :discounted_price => 800,
            :original_price => 1200,
            :start_on => Time.now - 2.hours,
            :end_on => Time.now+1.minutes + 10,
            :restaurant => Restaurant.last,
            :deal_template => DealTemplate.first,
            :quantity => 5

Transaction.destroy_all
Transaction.create :user => User.first,
                   :deal => Deal.last

Transaction.create :user => User.first,
                   :deal => Deal.last

Transaction.create :user => User.first,
                   :deal => Deal.last

Transaction.create :user => User.first,
                   :deal => Deal.last

Transaction.create :user => User.first,
                   :deal => Deal.last

Transaction.create :user => User.first,
                   :deal => Deal.first

Transaction.create :user => User.first,
                   :deal => Deal.first

Transaction.create :user => User.first,
                   :deal => Deal.first

Transaction.create :user => User.first,
                   :deal => Deal.first

RestaurantUser.destroy_all
RestaurantUser.create :user => User.all[0],
                      :restaurant => Restaurant.last,
                      :email => true,
                      :sms => true

#RestaurantUser.create :user => User.all[1],
#                      :restaurant => Restaurant.last,
#                      :sms => true,
#                      :email => true
