class Year < ActiveRecord::Base
  self.primary_key = 'year'
  has_many :months
  has_many :weeks
  has_many :days
  has_many :transactions, through: :days

  def self.generate_year(year)
    date1 = Date.new(year, 1, 1)
    date2 = Date.new(year, 12, 31)
    days = (date1..date2).map(&:to_s)
    days.each do |day|
      new_day = Day.new(date: Date.parse(day))
      new_day.save
    end
  end
end
