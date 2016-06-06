class ChangeDateIdsToStrings < ActiveRecord::Migration
  def change
    change_column :days, :month_id, :string
    change_column :days, :year_id, :string
    change_column :months, :year_id, :string
    change_column :months, :month, :string
    change_column :years, :year, :string
  end
end
