require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get plans" do
    get :plans
    assert_response :success
  end

  test "should get stripe_checkout" do
    get :stripe_checkout
    assert_response :success
  end

end
