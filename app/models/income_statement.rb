class IncomeStatement < ActiveRecord::Base

  @user = User.find(1) #replace with actual find-by functionality

  def self.monthly_view
    array_range = []

    TimePeriod.monthly.each do |month|

      category_totals = {}
      category_totals[month[0].month] = {}

      @user.categories.uniq.each do |c| 
        category_totals[month[0].month][c.root.name] = 0 if category_totals[month[0].month][c.root.name] == nil
        category_totals[month[0].month]["Total Food"] = 0 if category_totals[month[0].month]["Total Food"] == nil

        t = c.transactions.where(date: month[0]..month[1]).sum(:amount)

        category_totals[month[0].month][c.name] = t
        category_totals[month[0].month][c.root.name] += t
        category_totals[month[0].month]["Total Food"] += t if c.parent.name == "Total Food"

      end  
      array_range << category_totals
    end
    return array_range
  end  

end
