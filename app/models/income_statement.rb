class IncomeStatement

  attr_accessor :user, :increment, :start_date, :end_date
  attr_reader :time_period

  def initialize(user, increment, start_date, end_date=Date.today)
    @user = user
    @increment = increment
    @start_date = start_date
    @end_date = end_date
    @time_period = TimePeriod.dynamic_period(@increment.to_s, @start_date, @end_date)
  end

  def day_category_sum(category, day)
    @user.transactions.where({day_id: day.id, category: category}).sum(:amount)*-1
  end

  def category_sum(category, period)
    @user.transactions.joins(day: @increment).where({"days.#{@increment.to_s}_id": period.id, category: category}).sum(:amount)*-1
  end

  def category_over_time(category)
    category_totals = @time_period.map do |period|
      if @increment == :day
        day_category_sum(category, period)
      else
        category_sum(category, period)
      end
    end
    return category_totals
  end

  def parent_period_sum(parent, period)
    total = 0
    parent.leaves.each do |leaf|
      if @increment == :day
        total += day_category_sum(leaf, period)
      else
        total += category_sum(leaf, period)
      end
    end
    return total
  end

  def parent_category_over_time(parent)
    parent_totals = @time_period.map do |period|
      parent_period_sum(parent, period)
    end
  end

  def generate_table_hash(parents=Category.roots, hash={})
    parents.each do |parent|
        if !parent.children.empty? 
            hash[parent.name] = {}
            generate_table_hash(parent.children, hash[parent.name])
        else
            hash[parent.name] = category_over_time(parent)
        end
    end
    return hash
  end

  def to_sum(hash, array=[])
    working_array = array
    hash.each do |key,property|
      if property.class == Array
        working_array << property
      elsif property.class == Hash
        to_sum(property,working_array)
      end
    end
    return working_array
  end

  def category_sums(arrayofarrays)
    sums = []
    @time_period.length.times do |i|
      sums.push(0)
    end
    arrayofarrays.each do |array|
      array.each_with_index do |period, index|
        sums[index] += period
      end
    end
    return sums
  end

  def parent_sum(parent_hash)
    category_sums(to_sum(parent_hash))
  end

  def generate_net(table_hash)
    sums = []
    @time_period.length.times do |i|
      sums.push(0)
    end
    expenses = parent_sum(table_hash["Expenses"])
    income = parent_sum(table_hash["Income"])
    sums.each_with_index do |period, idx|
      sums[idx] = expenses[idx] + income[idx]
    end
  end

  def generate
    array_range = []
    @time_period.each do |period|
      category_totals = {}
      category_totals[period.id.to_s] = {}
      @user.categories.uniq.each do |category|
        if @increment == :day
          total = day_category_sum(category, period)
        else
          total = category_sum(category, period)
        end
        category_totals[period.id.to_s][category.name] = total

        category.ancestors.each do |ancestor|
          category_totals[period.id.to_s][ancestor.name] = 0 if category_totals[period.id.to_s][ancestor.name] == nil
          category_totals[period.id.to_s][ancestor.name] += total
        end
      end
      array_range << category_totals
    end
    return array_range
  end
  
  def self.year_to_date(user_id)
    @user = User.find(user_id)
    array_range = []
    period = TimePeriod.year_to_date
    period.each do |month|
      category_totals = {}
      category_totals[month.first.month] = {}
      @user.categories.uniq.each do |c| 
        t = @user.transactions.where({category: c, day_id: month.first..month.last}).sum(:amount)*-1
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

  def self.generate(user, time_period)
    array_range = []
    time_period.each do |increment|
      category_totals = {}
      category_totals[increment.id.to_s] = {}
      user.categories.uniq.each do |category|
        if increment.class == Day
          total = user.transactions.where(day_id: increment.id).sum(:amount)*-1
        else
          total = user.transactions.joins(day: increment.class.model_name.human.downcase.to_sym).where("days.#{increment.class.model_name.human.downcase}_id" => increment.id, category: category).sum(:amount)*-1
        end
        category_totals[increment.id.to_s][category.name] = total

        category.ancestors.each do |ancestor|
          category_totals[increment.id.to_s][ancestor.name] = 0 if category_totals[increment.id.to_s][ancestor.name] == nil
          category_totals[increment.id.to_s][ancestor.name] += total
        end
      end
      array_range << category_totals
    end
    return array_range
  end

  def self.year_to_date_by_cat(user_id, category)
    @user = User.find(user_id)
    period = TimePeriod.year_to_date
    category_totals = period.map do |month|
      @user.transactions.where({category: category, day_id: month.first..month.last}).sum(:amount)*-1
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
        t = c.transactions.where(day_id: month.first..month.last).sum(:amount)*-1
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