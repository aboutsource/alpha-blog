require "test_helper"

class DeleteCategoryTest < ActionDispatch::IntegrationTest

  setup do
    admin_user = User.create!(username: "vhodder", email: "vhodder@email.com",
                              password: "password", admin: true)
    sign_in_as(admin_user)
    @category = Category.create!(name: "Sports")
    @article = Article.create!(title: "Rugby is great", description: "This is a great sport", 
                                user: admin_user, category_ids: [1])
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
    # Check article show page
    get "/articles/1"
    assert_response :success
    # Check the title is there
    assert_match "Rugby is great", response.body
    # Check the description is there
    assert_match "This is a great sport", response.body
    # Check category button is in body
    assert_match "Sports", response.body

    # Delete the category
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

    # Go back to article show page
    get "/articles/1"
    assert_response :success
    # Check the title is still there
    assert_match "Rugby is great", response.body
    # Check the description is still there
    assert_match "This is a great sport", response.body
    # Check the category button is gone
    assert_no_match "Sports", response.body
  end

end
