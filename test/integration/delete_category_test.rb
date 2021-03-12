require "test_helper"

class DeleteCategoryTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "vhodder", email: "vhodder@email.com",
                              password: "password", admin: true)
    sign_in_as(@admin_user)
  end

  test "should delete category" do
    #TODO
  end

  test "should not delete associated article" do
    #TODO
  end

end
