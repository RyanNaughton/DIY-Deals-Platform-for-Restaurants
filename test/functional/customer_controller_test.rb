require 'test_helper'

class CustomerControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get confirm_email" do
    get :confirm_email
    assert_response :success
  end

  test "should get confirm_sms" do
    get :confirm_sms
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end
