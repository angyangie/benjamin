class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.integer :user_id      
      t.integer :category_id
      t.float   :amount
      t.string  :time_period
      t.timestamps null: false
    end
  end
end
