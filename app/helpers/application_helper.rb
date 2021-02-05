module ApplicationHelper

  def gravatar_for(user, options = { size: 80 })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatr_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatr_url, alt: user.username, class: "rounded shadow mx-auto d-block")
  end

  def current_user
    # return the details of the user who is logged in
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # checks if sm is logged in
    !!current_user
  end

end
