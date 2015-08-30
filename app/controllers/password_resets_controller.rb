class PasswordResetsController < ApplicationController
  def show
  end

  def create
    user = User.where(token: params[:token]).first

    if user && params[:token].present?
      user.set_encrypted_password
      user.generate_token
      user.save
      session[:user_id] = user.id
    else
      flash[:danger] = "Sorry, that link has expired. Please request a new password reset."
    end

    redirect_to root_path
  end

  def expired_token
  end
end