require "test_helper"

class DeleteCategoryTest < ActionDispatch::IntegrationTest

  setup do
    @category = Category.create(name: "Sports")
    @admin_user = User.create(username: "vhodder", email: "vhodder@email.com",
                              password: "password", admin: true)
    sign_in_as(@admin_user)
  end

  test "should delete category" do
    get "/categories/1"
    assert_response :success
    assert_match "Are you sure?", response.body
    assert_difference 'Category.count', -1 do
      delete category_path, params: { category: { name: "Sports" } }
    end
    assert_response :redirect
    assert_redirected_to categories_url
    follow_redirect!
    assert_match "Categories", response.body
  end

  test "should not delete associated article" do
    #TODO
  end

end

