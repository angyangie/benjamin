class IncomeStatement < ActiveRecord::Base

  @user = User.find(1) #replace with actual find-by functionality



  def self.monthly_view
    array_range = []
    TimePeriod.monthly.each do |month|
      category_totals = {}
      category_totals[month[0].month] = {}
      @user.categories.uniq.each do |c| 
        category_totals[month[0].month][c.name] = c.transactions.where(date: month[0]..month[1]).sum(:amount)
      end  
      array_range << category_totals
    end
    binding.pry
  end  

end
