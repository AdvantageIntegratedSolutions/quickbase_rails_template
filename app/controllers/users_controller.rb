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
      create_user
      redirect_to documents_path
    else
      flash[:danger] = "Sorry, that email address is not authorized to register."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def create_user
    @user.assign_attributes(user_params)
    @user.registration_status = 'Active'
    @user.generate_token
    @user.set_encrypted_password
    @user.save
  end
end