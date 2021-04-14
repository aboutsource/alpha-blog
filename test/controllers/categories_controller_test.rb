require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create!(id: 1, name: "Sports")
    @category2 = Category.create!(id: 2, name: "Food+Drink")
    @admin_user = User.create!(username: "vhodder", email: "vhodder@email.com",
                              password: "password", admin: true, email_confirmed: true))
    @article = Article.create!(id: 1, title: "Rugby is great", description: "This is nice sport", 
                                user: @admin_user, category_ids: [@category.id])
    @article2 = Article.create!(id: 2, title: "Archery is not a sport", description: "Archery is a discipline", 
                                user: @admin_user, category_ids: [@category.id, @category2.id])
    @article3 = Article.create!(id: 3, title: "Drinking Tea", description: "...is very good for you", 
                                user: @admin_user, category_ids: [@category2.id])
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@admin_user)
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    sign_in_as(@admin_user)
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: "Travel" } }
    end
    assert_response :redirect
    assert_redirected_to category_url(Category.last)
    follow_redirect!
    assert_match "Travel", response.body
  end

  test "should not create category if not admin" do
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: "Travel" } }
    end
    assert_response :redirect
    assert_redirected_to categories_url
  end

  test "should show articles listing in category page" do
    get category_url(@category)
    assert_response :success

    assert_match "Category: #{@category.name}", response.body
    assert_match "Articles", response.body
    assert_select "a[href=?]", article_path(@article), text: @article.title
    assert_select "a[href=?]", article_path(@article2), text: @article2.title

    assert_no_match "#{@article3.title}", response.body
    assert_select "a[href=?]", article_path(@article3), text: @article3.title, :count => 0
  end
end
