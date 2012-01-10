require 'spec_helper'

describe SmsController, "handling a post from twilio" do

  it "should render generalized sms template" do
    post :receive, {:To => "+13122573773", :From => "+13124769626", :Body => "yay"}
    response.should render_template('sms/sms_response.xml')
  end

end
