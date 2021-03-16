require "test_helper"

class DeleteCategoryTest < ActionDispatch::IntegrationTest

  setup do
    admin_user = User.create!(username: "vhodder", email: "vhodder@email.com",
                              password: "password", admin: true)
    sign_in_as(admin_user)
    @category = Category.create!(id: 1, name: "Sports")
    @article = Article.create!(id: 1, title: "Rugby is great", description: "This is a great sport", 
                                user: admin_user, category_ids: [@category.id])
  end


  test "should not delete associated article" do

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

    # Check if article is unaffected by category deletion
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
