class PagesController < ApplicationController
  def home
    redirect_to articles_path if logged_in?
  end

  def about
    # TODO
  end

  def search
    if params[:search].blank?
      flash[:alert] = "Search cannot be blank"
      redirect_to root_path
    else
      parameter = params[:search].downcase
      @articles = Article.where('lower(title) LIKE :search OR lower(description) LIKE :search', 
                  search: "%#{parameter}%")
    end 
  end

end
