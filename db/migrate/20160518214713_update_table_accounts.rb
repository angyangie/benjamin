class UpdateTableAccounts < ActiveRecord::Migration
  def change
    rename_column :accounts, :type, :acct_type
    rename_column :accounts, :subtype, :acct_subtype
  end
end
