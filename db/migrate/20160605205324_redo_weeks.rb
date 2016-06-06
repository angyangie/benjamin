class RedoWeeks < ActiveRecord::Migration
  def change
    drop_table :weeks
    create_table :weeks, {id: false} do |t|
      t.string :week
      t.string :year_id
    end
  end
end
