class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if !@user.valid?
      render :new and return
    end

    @user = User.where(email: params[:user][:email]).first

    if @user
      @user.assign_attributes(user_params)
      @user.set_encrypted_password
      @user.save
      redirect_to documents_path
    else
      flash[:danger] = "Sorry, that email address cannot access this site."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end