class UsersController < ApplicationController

  def new

  end

  def index

  end

  def create
    @user = User.new(user_params)
     if @user.save
       session[:user_id] = @user.id
       redirect_to user_path(@user)
     else
      flash[:error] = "Your Passwords did not match!"
      redirect_to signup_path
     end

  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
