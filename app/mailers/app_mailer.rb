class AppMailer < ActionMailer::Base
  def send_forgot_password(user)
    @user = user
    mail to: @user.email, from: 'systemuser@emailqb.com', subject: 'Password Reset Link'
  end
end