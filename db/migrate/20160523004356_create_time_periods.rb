class CreateTimePeriods < ActiveRecord::Migration
  def change
    create_table :time_periods do |t|

      t.timestamps null: false
    end
  end
end
