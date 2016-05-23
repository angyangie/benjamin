class TimePeriod < ActiveRecord::Base

  @today = Date.today

   def self.monthly
    month_array = []
    x = 1
    while x <= @today.month
      start = Date.new(@today.year, x, 1)
      month_array << [start, start.end_of_month]
      x +=1 
    end
    return month_array
  end

end
