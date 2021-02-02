class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # why don't you need article_params at the top too? Because you need to set_article first

  def show
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    # temporary solution to assign a user automatically
    # (until we create a log in/out functionality)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Yay, your post was saved!"
      redirect_to @article
      # code to show action path
      # can also write `redirect_to article_path(@article)`
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Yay, you made your post even more beautiful"
      redirect_to @article
    else
      render 'edit'
    end 
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
    # :article = key for displaying title and description from article object
  end

end
