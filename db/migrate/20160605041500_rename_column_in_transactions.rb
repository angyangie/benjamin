class RenameColumnInTransactions < ActiveRecord::Migration
  def change
    rename_column :transactions, :date, :day_id
  end
end
