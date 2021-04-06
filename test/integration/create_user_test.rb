require "test_helper"

class CreateUserTest < ActionDispatch::IntegrationTest

  test "get sign up form and create new user" do 
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: {user: { username: "Victoria", email: "victoria@email.com", 
                                        password: "password", password_confirmation: "password", 
                                        email_confirmed: true} }
    end
    assert_response :redirect
    assert_redirected_to root_path
    follow_redirect!
    assert_select "div.alert"
    assert_match "Please check your emails to confirm your sign up", response.body
  end

end
