class AccountsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @accounts = @user.accounts
  end
end
