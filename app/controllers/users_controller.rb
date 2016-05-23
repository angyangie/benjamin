class UsersController < ApplicationController

  def new
  end

  def index
  end

  def create
    @user = User.new(user_params)
        if !@user.save
          flash[:errors] = []
          flash[:message] = "Please fix the following errors:"
          @user.errors.each do |k,v|
              flash[:errors] << "#{k}: #{v}"
          end
          redirect_to signup_path
        else
           session[:user_id] = @user.id
           redirect_to user_path(@user)
        end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :email, :password, :password_confirmation)
  end

end
