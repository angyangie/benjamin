class IncomeStatement < ActiveRecord::Base
  

  def self.year_to_date(user_id)  
    @user = User.find(user_id)
    
    array_range = []
    category_totals = {}
    category_totals[Date.today.year] = {}
    time_range = TimePeriod.year_to_date

    # Iterate through each month
    time_range.each_with_index do |month, index|
      category_totals[month.first.year][month.first.month] = {}
      
      # Sum transactions by categories
      @user.categories.uniq.each do |c| 
        t = c.transactions.where(date: month.first..month.last).sum(:amount)*-1
        category_totals[month.first.year][month.first.month][c.name] = t

        # Add sum to each higher-level anscestor category
        c.ancestors.each do |a|
          category_totals[month.first.year][month.first.month][a.name] = 0 if category_totals[month.first.year][month.first.month][a.name] == nil
          category_totals[month.first.year][month.first.month][a.name] += t
        end  
      end
      
      # Sum net spending / savings
      category_totals[month.first.year][month.first.month]["Income"].nil? ? i = 0 : i = category_totals[month.first.year][month.first.month]["Income"]
      category_totals[month.first.year][month.first.month]["Expenses"].nil? ? e = 0 : e = category_totals[month.first.year][month.first.month]["Expenses"]
      category_totals[month.first.year][month.first.month]["Net"] = i + e
      # Add completed month hash to the array
      if index == time_range.length - 1
        array_range << category_totals
      end
    end
    return array_range
  end  

  def self.to_year_end(user_id)
    @user = User.find(user_id)
    
    array_range = []
    category_totals = {}
    category_totals["budget"] = {}
    time_range = TimePeriod.to_year_end 

    time_range.each_with_index do |month, index|
      category_totals["budget"][month.first.month] = {}    
      
        # Sum budgets by categories
        @user.budgets.each do |b|
          t = b.amount*-1
          category_totals["budget"][month.first.month][b.category.name] = t
          
          # Add sum to each higher-level anscestor category
          b.category.ancestors.each do |a|
            category_totals["budget"][month.first.month][a.name] = 0 if category_totals["budget"][month.first.month][a.name] == nil
            category_totals["budget"][month.first.month][a.name] += t
          end
        end  
      
      # Sum net spending / savings
      category_totals["budget"][month.first.month]["Income"].nil? ? i = 0 : i = category_totals["budget"][month.first.month]["Income"]
      category_totals["budget"][month.first.month]["Expenses"].nil? ? e = 0 : e = category_totals["budget"][month.first.month]["Expenses"]
      category_totals["budget"][month.first.month]["Net"] = i + e

      # Add completed month hash to the array
      if index == time_range.length - 1
        array_range << category_totals
      end
    end
    return array_range
  end

  def self.last_twelve_months(user_id)  
    @user = User.find(user_id)
    
    array_range = []
    category_totals = {}
    category_totals[Date.today.last_year.year] = {}
    time_range = TimePeriod.last_twelve_months

    # Iterate through each month
    time_range.each_with_index do |month, index|
      category_totals[month.first.year][month.first.month] = {}
      
      # Sum transactions by categories
      @user.categories.uniq.each do |c| 
        t = c.transactions.where(date: month.first..month.last).sum(:amount)*-1
        category_totals[month.first.year][month.first.month][c.name] = t

        # Add sum to each higher-level anscestor category
        c.ancestors.each do |a|
          category_totals[month.first.year][month.first.month][a.name] = 0 if category_totals[month.first.year][month.first.month][a.name] == nil
          category_totals[month.first.year][month.first.month][a.name] += t
        end  
      end
      
      # Sum net spending / savings
      category_totals[month.first.year][month.first.month]["Income"].nil? ? i = 0 : i = category_totals[month.first.year][month.first.month]["Income"]
      category_totals[month.first.year][month.first.month]["Expenses"].nil? ? e = 0 : e = category_totals[month.first.year][month.first.month]["Expenses"]
      category_totals[month.first.year][month.first.month]["Net"] = i + e
      # Add completed month hash to the array
      if index == time_range.length - 1
        array_range << category_totals
      end
    end
    return array_range
  end  

  # def self.monthly_by_year_view(user_id, year)
  # @user = User.find(user_id)
  # array_range = []
  
  # TimePeriod.monthly_by_year(year).each do |month|
    
  #   category_totals = {}
  #   category_totals[month[0].month] = {}
    
  #   @user.categories.uniq.each do |c| 
  #     t = c.transactions.where(date: month[0]..month[1]).sum(:amount)
     
  #     category_totals[month[0].month][c.name] = t
      
  #     c.ancestors.each do |a|
  #       category_totals[month[0].month][a.name] = 0 if category_totals[month[0].month][a.name] == nil
  #       category_totals[month[0].month][a.name] += t
  #     end
    
  #   end  
    
  #   array_range << category_totals
  
  # end
  #   return array_range
  # end  

  # private
  # def self.period_setter
  #   TimePeriod.ltm + TimePeriod.monthly  
  # end
  
end