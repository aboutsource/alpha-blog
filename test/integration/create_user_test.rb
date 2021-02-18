require "test_helper"

class CreateUserTest < ActionDispatch::IntegrationTest

  test "get sign up form and create new user" do 
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: {user: { username: "Victoria", email: "victoria@email.com", 
                                        password: "password", password_confirmation: "password" } }
    end

    follow_redirect!
    # test if on articles listing
    assert_response :success
    assert_match "Victoria", response.body
  end

end