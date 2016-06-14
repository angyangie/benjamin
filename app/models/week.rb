class Week < ActiveRecord::Base
  self.primary_key = 'week'
  has_many :days
  has_many :transactions
  belongs_to :year

  after_initialize :set_year

  private

  def set_year
    self.year_id = self.week[-4..-1]
    self.save
  end
end
