class RedoMonthsTable < ActiveRecord::Migration
  def change
    drop_table :months
    create_table :months, {id: false} do |t|
      t.string :month
      t.string :year_id
    end
  end
end
