class ApplicationController < ActionController::Base
  # https://guides.rubyonrails.org/security.html#csrf-countermeasures
  # protect_from_forgery with: :exception 

  helper_method :current_user, :logged_in?

  def current_user
    # return the details of the user who is logged in
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # checks if sm is logged in
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

end
