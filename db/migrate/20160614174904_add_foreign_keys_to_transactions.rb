class AddForeignKeysToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :week_id, :string
    add_column :transactions, :month_id, :string
    add_column :transactions, :year_id, :string
  end
end
