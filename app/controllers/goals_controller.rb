require 'pry'

class GoalsController < ApplicationController

  def index

  end 

  def create
    @user = current_user
    @goal = Goal.find_or_create_by(product_url: params[:goal][:product_url], user_id: user.id)
    redirect_to goal_path(@user)
  end 

  def show 



  end

end
