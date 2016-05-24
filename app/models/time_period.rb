class TimePeriod < ActiveRecord::Base

  @today = Date.today

   def self.monthly
    month_array = []
    x = 1
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
