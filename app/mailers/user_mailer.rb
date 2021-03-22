class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/welcome'
    mail(to: @user.email, subject: 'Welcome to Apha Blog')
  end

end
