require 'spec_helper'

describe "user_model" do

  before do
    Restaurant.create(:subdomain => 'foo', :smsNum => '3122573773')
  end

  it "sends email confirmation" do
    UserMailer.should_receive(:confirm_email).and_return(mock("mailer", :deliver => true))
    User.create email:"ryan.j.naughton@gmail.com", phone:"7577737480", password:"123", password_confirmation:"123"
  end

end
