class CreateDays < ActiveRecord::Migration
  def change
    create_table :days, {id: false} do |t|
      t.date :date
      t.integer :month_id
      t.integer :year_id

      t.timestamps null: false
    end
  end
end
