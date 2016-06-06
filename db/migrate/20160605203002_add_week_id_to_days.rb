class AddWeekIdToDays < ActiveRecord::Migration
  def change
    add_column :days, :week_id, :string
  end
end
