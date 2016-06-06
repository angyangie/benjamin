class Day < ActiveRecord::Base
  self.primary_key = 'date'
  belongs_to :week
  belongs_to :month
  belongs_to :year
  has_many :transactions

  after_initialize :set_week, :set_month, :set_year

  private

  def set_week
    if self.date.cweek == 53 && self.date.month == 1
      self.week = Week.find_or_create_by(week: self.date.cweek.to_s.rjust(2,"0") + (self.date.year - 1).to_s)
    elsif self.date.cweek == 1 && self.date.month == 12
      self.week = Week.find_or_create_by(week: self.date.cweek.to_s.rjust(2,"0") + (self.date.year + 1).to_s)
    else
      self.week = Week.find_or_create_by(week: self.date.cweek.to_s.rjust(2,"0") + self.date.year.to_s)
    end
  end

  def set_month
    self.month = Month.find_or_create_by(month: self.date.month.to_s.rjust(2,"0") + self.date.year.to_s)
  end

  def set_year
    self.year = Year.find_or_create_by(year: self.date.year.to_s)
  end
end