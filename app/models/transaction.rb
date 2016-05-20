class Transaction < ActiveRecord::Base
  self.primary_key = 'plaid_trans_id'
  belongs_to :account
  belongs_to :category
  delegate :user, :to => :account

  def self.create_accounts(plaid_user_accounts, public_token, user_id)
    plaid_user_accounts.each do |acct|
      account = Account.find_by(plaid_acct_id: acct.id)
      if account
        account.update(
          account_name: acct.meta["name"],
          account_number: acct.meta["number"],
          available_balance: acct.available_balance,
          current_balance: acct.current_balance,
          institution_type: acct.institution_type,
          name: acct.name,
          numbers: acct.numbers,
          acct_subtype: acct.subtype,
          acct_type: acct.type,
          user_id: user_id,
          public_token_id: public_token.id
          )
      else
        Account.create(
          plaid_acct_id: acct.id,
          account_name: acct.meta["name"],
          account_number: acct.meta["number"],
          available_balance: acct.available_balance,
          current_balance: acct.current_balance,
          institution_type: acct.institution_type,
          name: acct.name,
          numbers: acct.numbers,
          acct_subtype: acct.subtype,
          acct_type: acct.type,
          user_id: user_id,
          public_token_id: public_token.id
          )
      end
    end
  end

  def self.create_transactions(plaid_user_transactions)
    plaid_user_transactions.each do |transaction|
      newtrans = Transaction.find_by(plaid_trans_id: transaction.id)

      vendor_address = transaction.location["address"]
      vendor_city = transaction.location["city"]
      vendor_state = transaction.location["state"]
      vendor_zip = transaction.location["zip"]

      if !transaction.location["coordinates"].nil?
        vendor_lat = transaction.location["coordinates"]["lat"]
        vendor_lon = transaction.location["coordinates"]["lon"]
      else
        vendor_lat = nil
        vendor_lon = nil
      end

      if newtrans
        newtrans.update(
          plaid_trans_id: transaction.id,
          account_id: transaction.account,
          amount: transaction.amount,
          trans_name: transaction.name,
          plaid_cat_id: transaction.category_id.to_i,
          plaid_cat_type: transaction.type["primary"],
          date: transaction.date.to_date,

          vendor_address: vendor_address,
          vendor_city: vendor_city,
          vendor_state: vendor_state,
          vendor_zip: vendor_zip,
          vendor_lat: vendor_lat,
          vendor_lon: vendor_lon,

          pending: transaction.pending,
          pending_transaction: transaction.pending_transaction,
          name_score: transaction.score["name"]
          )
      else
        newtrans = Transaction.create(
          plaid_trans_id: transaction.id,
          account_id: transaction.account,
          amount: transaction.amount,
          trans_name: transaction.name,
          plaid_cat_id: transaction.category_id.to_i,
          plaid_cat_type: transaction.type["primary"],
          date: transaction.date.to_date,

          vendor_address: vendor_address,
          vendor_city: vendor_city,
          vendor_state: vendor_state,
          vendor_zip: vendor_zip,
          vendor_lat: vendor_lat,
          vendor_lon: vendor_lon,

          pending: transaction.pending,
          pending_transaction: transaction.pending_transaction,
          name_score: transaction.score["name"]
          )
      end
      if newtrans.plaid_cat_id == 0 || newtrans.plaid_cat_id == nil
        newtrans.category = Category.find_by(name: "Tag")
        newtrans.save
      else
        newtrans.category = PlaidCategory.find_by(plaid_cat_id: newtrans.plaid_cat_id).category
        newtrans.save
      end
    end
  end
end
