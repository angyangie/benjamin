class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.string :week
      t.string :year_id

      t.timestamps null: false
    end
  end
end
