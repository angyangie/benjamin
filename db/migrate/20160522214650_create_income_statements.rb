class CreateIncomeStatements < ActiveRecord::Migration
  def change
    create_table :income_statements do |t|

      t.timestamps null: false
    end
  end
end
