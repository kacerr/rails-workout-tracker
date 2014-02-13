require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

	test "should let the user sign in with correct password" do
		@user = users(:one)
    post :create, session: { email: @user.email, password: 111111 }
    assert_redirected_to welcome_path
    # we also want to check for some content on the page
  end

	test "should not let the user sign in with invalid password" do
		@user = users(:one)
    post :create, session: { email: @user.email, password: :invalid_password }
    # now we should be redirected back to /signin 
    assert_redirected_to signin_path
    # we also want to check for error message being sent
    assert flash[:error]=="Invalid email/password combination", "Where is my error flash?"
  end

  # test "the truth" do
  #   assert true
  # end
end
