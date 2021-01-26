class ArticlesController < ApplicationController

    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new

    end

    def create
        @article = Article.new(params.require(:article).permit(:title, :description))
        # :article = key for displaying title and description from article object
        @article.save
        redirect_to @article
        # code to show action path
    end

end
