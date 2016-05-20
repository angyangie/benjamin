class PlaidapiController < ApplicationController
  skip_before_action :require_login

  def add_account
    #1 generate a public token for the user
    public_token = PublicToken.find_or_create_by(token: params[:public_token])

    #2 save public token to user's cashflow account
    save_public_token(public_token) if session[:user_id]

    #3 Exchange the Link public_token for a Plaid API access token
    exchange_token_response = Argyle.plaid_client.exchange_token(public_token.token)

    #4 Initialize a Plaid user
    @plaid_user = Argyle.plaid_client.set_user(exchange_token_response.access_token, ['connect'])

    #5 pass data for parsing
    create_accounts(@plaid_user.accounts, public_token)
    create_transactions(@plaid_user.transactions)

    @user = User.find(session[:user_id])
    redirect_to @user
  end

  private
  def save_public_token(token)
    cashflow_current_user = User.find_by(id: session[:user_id])
    cashflow_current_user.public_tokens << token
  end

  def create_accounts(plaid_user_accounts, public_token)
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
          acct_type: acct.type
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
          user_id: session[:user_id],
          public_token_id: public_token.id
          )
      end
    end
  end

  def create_transactions(plaid_user_transactions)
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
      binding.pry
      newtrans.category = PlaidCategory.find_by(plaid_cat_id: newtrans.plaid_cat_id).category
      newtrans.save
      binding.pry
    end
  end
end
