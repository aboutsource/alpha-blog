require "test_helper"

class ListSearchResultsTest < ActionDispatch::IntegrationTest
  def setup
    # Create articles for "should show search results" test
    @article = Article.create(title: "A title", description: "This is great")
    @article2 = Article.create(title: "Another title", description: "This is really great")
  end

  test "should show search results" do
    # TODO:
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
    # TODO
  end

end
