class IncomeStatement < ActiveRecord::Base
  
  def self.monthly_view(user_id)
    @user = User.find(user_id)
    array_range = []

    TimePeriod.monthly.each do |month|
      category_totals = {}
      category_totals[month.first.month] = {}

      @user.categories.uniq.each do |c| 
        t = c.transactions.where(date: month.first..month.last).sum(:amount)*-1
        category_totals[month.first.month][c.name] = t
        
        c.ancestors.each do |a|
          category_totals[month.first.month][a.name] = 0 if category_totals[month.first.month][a.name] == nil
          category_totals[month.first.month][a.name] += t
        end
      end

      if Date.today.month < month.first.month
        @user.budgets.each do |b|
          t = b.amount*-1
          category_totals[month.first.month][b.category.name] = t
          
          b.category.ancestors.each do |a|
            category_totals[month.first.month][a.name] = 0 if category_totals[month.first.month][a.name] == nil
            category_totals[month.first.month][a.name] += t
          end
        end  
      end
      category_totals[month.first.month]["Income"].nil? ? i = 0 : i = category_totals[month.first.month]["Income"]
      category_totals[month.first.month]["Expenses"].nil? ? e = 0 : e = category_totals[month.first.month]["Expenses"]
      category_totals[month.first.month]["Net"] = i + e
      array_range << category_totals
    end
    return array_range
  end  

    def self.monthly_by_year_view(user_id, year)
    @user = User.find(user_id)
    array_range = []
    
    TimePeriod.monthly_by_year(year).each do |month|
      
      category_totals = {}
      category_totals[month[0].month] = {}
      
      @user.categories.uniq.each do |c| 
        t = c.transactions.where(date: month[0]..month[1]).sum(:amount)
       
        category_totals[month[0].month][c.name] = t
        
        c.ancestors.each do |a|
          category_totals[month[0].month][a.name] = 0 if category_totals[month[0].month][a.name] == nil
          category_totals[month[0].month][a.name] += t
        end
      
      end  
      
      array_range << category_totals
    
    end
    
    return array_range
  end  
end