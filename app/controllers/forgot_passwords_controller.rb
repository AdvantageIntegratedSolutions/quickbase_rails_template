class ForgotPasswordsController < ApplicationController
  def new
  end

  def create
    user = User.where(email: params[:email]).first

    if user
      user.update_attributes(encrypted_password: '', registration_status: 'Reset')
      AppMailer.send_forgot_password(user).deliver_now
      flash[:success] = "Your request was received. Please check your inbox for instructions on resetting your password."
      redirect_to root_path
    else
      flash[:danger] = params[:email].blank? ? "Email cannot be blank." : "Sorry, we couldn't find a user with that email in the system."
      redirect_to forgot_password_path
    end
  end
end