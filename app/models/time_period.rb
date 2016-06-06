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

  def self.dynamic_period(increment, start_date, end_date=Date.today)
    if increment == "month"
      return TimePeriod.monthly(start_date, end_date)
    elsif increment == "week"
      return TimePeriod.weekly(start_date, end_date)
    elsif increment == "day"
      return TimePeriod.daily(start_date, end_date)
    end
  end

  def self.daily(start_date, end_date)
    time_period = []
    first_day = Day.find_by(date: start_date)
    last_day = Day.find_by(date: end_date)
    time_period << first_day
    time_period << last_day
    next_day = Day.find_by(date: (first_day.date + 1.day))
    until next_day == last_day
      time_period.insert(-2, next_day)
      next_day = Day.find_by(date: (first_day.date + 1.day))
    end
    return time_period
  end

  def self.weekly(start_date, end_date)
    time_period = []
    first_week = Day.find_by(date: start_date).week
    last_week = Day.find_by(date: end_date).week
    time_period << first_week
    time_period << last_week
    next_week = Day.find_by(date: (first_week.days.first.date + 1.week)).week
    until next_week == last_week
      time_period.insert(-2, next_week)
      next_week = Day.find_by(date: (next_week.days.first.date + 1.week)).week
    end
    return time_period
  end

  def self.monthly(start_date, end_date)
    time_period = []
    first_month = Day.find_by(date: start_date).month
    last_month = Day.find_by(date: end_date).month
    time_period << first_month
    time_period << last_month
    next_month = Day.find_by(date: (first_month.days.first.date + 1.month)).month
    until next_month == last_month
      time_period.insert(-2, next_month)
      next_month = Day.find_by(date: (next_month.days.first.date + 1.month)).month
    end
    return time_period
  end

end
