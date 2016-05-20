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
    @user = User.find(session[:user_id])

    Transaction.create_accounts(@plaid_user.accounts, public_token, @user.id)
    Transaction.create_transactions(@plaid_user.transactions)
    
    redirect_to @user
  end

  private
  def save_public_token(token)
    cashflow_current_user = User.find_by(id: session[:user_id])
    cashflow_current_user.public_tokens << token
  end
end
