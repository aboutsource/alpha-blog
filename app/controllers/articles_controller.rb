class ArticlesController < ApplicationController

    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(params.require(:article).permit(:title, :description))
        # :article = key for displaying title and description from article object
        if @article.save
            flash[:notice] = "Yay, your post was saved!"
            redirect_to @article
        else
            render 'new'
        # code to show action path
        end
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Yay, you made your post even more beautiful"
            redirect_to @article
        else
            render 'edit'
        end 
    end

end
