class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy, :data]

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

  end

  def data
    respond_to do |format|
      format.json {
        render :json
      }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :email, :password, :password_confirmation)
  end

end
