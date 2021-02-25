require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Travel", id: 1)
    @test_user = User.create(username: "Victoria", email: "victoria@email.com",
                              password: "password", admin: false)
    sign_in_as(@test_user)
  end

  test "get new article form and create new article" do 
    get "/articles/new"  
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: {article: { title: "Nice title", description: "Nice description", 
                                  category_ids: [1] } }
    end
    assert_response :redirect
    assert_redirected_to article_url(Article.last)
    follow_redirect!
    assert_match "Nice title", response.body
  end
end
