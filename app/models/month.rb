class Month < ActiveRecord::Base
  self.primary_key = 'month'
  belongs_to :year
  has_many :days
  has_many :transactions, through: :days

  after_initialize :set_year

  private

  def set_year
    self.year_id = self.month[-4..-1]
    self.save
  end
end
