require 'test_helper'

class DealControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get buy" do
    get :buy
    assert_response :success
  end

end
