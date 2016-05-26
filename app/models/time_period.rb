class TimePeriod < ActiveRecord::Base

  @today = Date.today

  def self.year_to_date
    month_array = []
    x = 1
    while x <= @today.month
      start = Date.new(@today.year, x, 1)
      month_array << [start, start.end_of_month]
      x +=1 
    end
    return month_array
  end

  def self.last_twelve_months
    month_array = []
    x = @today.month + 1
    while x <= 12
      start = Date.new(@today.prev_year.year, x, 1)
      month_array << [start, start.end_of_month]
      x +=1
    end
    return month_array
  end

  def self.budget
    month_array = []
    x = @today.month + 1
    while x <= 12
      start = Date.new(@today.year, x, 1)
      month_array << [start, start.end_of_month]
      x +=1
    end
    return month_array
  end

  def self.monthly_by_year(year)
    month_array = []
    x = 1
    while x <= 12
      start = Date.new(year, x, 1)
      month_array << [start, start.end_of_month]
      x += 1
    end
    return month_array
  end

end
