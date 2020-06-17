class UserIntroMailer < ApplicationMailer
  default from: "noreply@conference.upt.ro"
  
  def notify_user(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to EDEN 2020')
  end
  
end
