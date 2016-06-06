class RedoYearsTable < ActiveRecord::Migration
  def change
    drop_table :years
    create_table :years, {id: false} do |t|
      t.string :year
    end
  end
end
