class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(email: params[:email]).first

    if user && user.registration_status != 'Active'
      flash[:danger] = "You recently requested to reset your password. Please check your email for a link to do so before you can log in."
      redirect_to sign_in_path and return
    end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to documents_path
    else
      flash[:danger] = "Sorry, the email or password you entered was incorrect."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
  end
end