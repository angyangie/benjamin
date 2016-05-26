class BudgetsController < ApplicationController
  
  def new
    @budget = Budget.new
  end

  def create
    budget = Budget.create(budget_params)
    @user = User.find(params[:user_id])
    budget.user = @user
    budget.save
    redirect_to @user
  end

  private
  def budget_params
    params.require(:budget).permit(:amount, :category_id)
  end
end

