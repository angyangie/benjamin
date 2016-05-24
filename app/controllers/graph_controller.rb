class GraphController < ApplicationController
  def index
  end

  def data
    @user = User.find(session[:user_id])
    respond_to do |format|
      format.js
    end
  end
end
