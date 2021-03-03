require "test_helper"

class ListSearchResultsTest < ActionDispatch::IntegrationTest
  def setup
    user = User.create!(username: "Victoria", email: "victoria@email.com", password: "secretpassword")
    @article = Article.create!(title: "A title", description: "This is nice", user: user)
    @article2 = Article.create!(title: "Another nice title", description: "This is really nice", user: user)
    @article3 = Article.create!(title: "A bad title", description: "This is really terrible", user: user)
  end

  test "should show search results" do
    get '/search?search=nice'
    assert_response :success
    assert_match "Search Result", response.body
    assert_select "a[href=?]", article_path(@article), text: @article.title
    assert_select "a[href=?]", article_path(@article2), text: @article2.title
  end

  test "should show error if search bar empty" do
    get '/search'
    assert_response :redirect
    follow_redirect!
    assert_match "Search cannot be blank", response.body
    assert_select "div.alert"
    assert_select "button.close"
  end 

  test "should show no results if no results found" do
    get '/search?search=mug'
    assert_response :success
    assert_match "No results found", response.body
  end

end
