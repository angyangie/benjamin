class IncomeStatement < ActiveRecord::Base
  
  def self.year_to_date(user_id)
    @user = User.find(user_id)
    array_range = []
    period = TimePeriod.year_to_date
    period.each do |month|
      category_totals = {}
      category_totals[month.first.month] = {}
      @user.categories.uniq.each do |c| 
        t = @user.transactions.where({category: c, date: month.first..month.last}).sum(:amount)*-1
        # categ.transactions.joins(account: :user).where('accounts.user_id' => 2)
        category_totals[month.first.month][c.name] = t
        
        c.ancestors.each do |a|
          category_totals[month.first.month][a.name] = 0 if category_totals[month.first.month][a.name] == nil
          category_totals[month.first.month][a.name] += t
        end
      end
      category_totals[month.first.month]["Income"].nil? ? i = 0 : i = category_totals[month.first.month]["Income"]
      category_totals[month.first.month]["Expenses"].nil? ? e = 0 : e = category_totals[month.first.month]["Expenses"]
      category_totals[month.first.month]["Net"] = i + e
      array_range << category_totals
    end
    return_hash = {}
    return_hash[period.first.first.year] = array_range
    return return_hash
  end 

  def self.year_to_date_by_cat(user_id, category)
    @user = User.find(user_id)
    period = TimePeriod.year_to_date
    category_totals = period.map do |month|
      @user.transactions.where({category: category, date: month.first..month.last}).sum(:amount)*-1
    end
    return category_totals
  end

  def self.different_method(parents, hash, user_id)
    parents.each do |parent|
        if !parent.children.empty? 
            hash[parent.name] = {}
            IncomeStatement.different_method(parent.children, hash[parent.name], user_id)
        else
            hash[parent.name] = IncomeStatement.year_to_date_by_cat(user_id, parent)
        end
    end
    return hash
  end

  def self.budget(user_id)
    @user = User.find(user_id)
    array_range = []
    period = TimePeriod.budget
    period.each do |month|
      category_totals = {}
      category_totals[month.first.month] = {}
        
      @user.budgets.each do |b|
        if b.category.root.name == "Expenses"
          t = b.amount*-1
        else
          t = b.amount
        end
        category_totals[month.first.month][b.category.name] = t
        
        b.category.ancestors.each do |a|
          category_totals[month.first.month][a.name] = 0 if category_totals[month.first.month][a.name].nil?
          category_totals[month.first.month][a.name] += t
        end
      end 
      
      category_totals[month.first.month]["Income"].nil? ? i = 0 : i = category_totals[month.first.month]["Income"]
      category_totals[month.first.month]["Expenses"].nil? ? e = 0 : e = category_totals[month.first.month]["Expenses"]
      category_totals[month.first.month]["Net"] = i + e
      array_range << category_totals
    end
    return_hash = {}
    return_hash[period.first.first.year] = array_range
    return return_hash
  end

  def self.last_twelve_months(user_id)
    @user = User.find(user_id)
    array_range = []
    period = TimePeriod.last_twelve_months
    period.each do |month|
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
      category_totals[month.first.month]["Income"].nil? ? i = 0 : i = category_totals[month.first.month]["Income"]
      category_totals[month.first.month]["Expenses"].nil? ? e = 0 : e = category_totals[month.first.month]["Expenses"]
      category_totals[month.first.month]["Net"] = i + e
      array_range << category_totals
    end
    return_hash = {}
    return_hash[period.first.first.year] = array_range
    return return_hash
  end

  def self.display_table_data(user_id)
    ytd_data = IncomeStatement.year_to_date(user_id)
    budget_data = IncomeStatement.budget(user_id)
    table_data = ytd_data.values.first + budget_data.values.first
    return table_data
  end



end