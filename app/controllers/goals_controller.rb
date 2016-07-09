require 'pry'

class GoalsController < ApplicationController

  def index

  end 

  def create
    @user = current_user
    @goal = Goal.find_or_create_by(name: params[:goal][:name], user_id: current_user.id)
    redirect_to goals_path(@user)


  end 

  def show 



  end

end
