class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create

  end

  def user_register
    @already = User.find_by_email(params[:user][:email])
    @user = User.new(new_params)
    if @already.blank?
      if @user.save
        sign_in :user, @user
        redirect_to welcomes_url
      else
        puts"sssssssssssssssssssssssssss here 1",@user.errors.messages.inspect
        flash[:success] = 'User Already Exist'
        render :register
      end
    else
      puts"sssssssssssssssssssssssssss here 1"
      flash[:success] = 'User Already Exist.'
      render :register
    end
  end

  def user_login
    @user  = User.find_by_email(params[:user][:email])
    if !@user.blank?
      if @user.valid_password?(params[:user][:password])
        sign_in :user, @user
        redirect_to  welcomes_url
      else
        flash[:error] = 'Invalid Email.'
        render :login
      end
    else
      flash[:error] = 'Invalid Credentials.'
      render :login
    end
  end

  def register
    @user = User.new
  end

  def logout
    sign_out current_user  if current_user
    redirect_to root_url
  end

  private

  def new_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
