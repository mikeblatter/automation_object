require 'test_helper'

class UserInterfaceExampleControllerTest < ActionController::TestCase
  test "should get new_window" do
    get :new_window
    assert_response :success
  end

end
