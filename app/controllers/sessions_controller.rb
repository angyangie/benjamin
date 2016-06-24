class SessionsController < ApplicationController

  def new
  end

  def create
   @user = User.find_by(email: params[:user][:email])
   attempts = 0
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:message] = "Wrong email or password"
      attempts += 1
      redirect_to login_path
    end
  end

  def destroy
    session.delete :user_id
    flash[:message] = "Successfully logged out."
    redirect_to login_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end



