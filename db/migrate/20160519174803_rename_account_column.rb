class RenameAccountColumn < ActiveRecord::Migration
  def change
    rename_column :transactions, :plaid_acct_id, :account_id
  end
end
