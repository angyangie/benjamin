class AccountsController < ApplicationController
  def index
    @accounts = current_user.accounts
  end

  def create
    # Plaid API Authentication & Exchange
    public_token = PublicToken.find_or_create_by(token: params[:public_token])
    save_public_token(public_token)
    exchange_token_response = Argyle.plaid_client.exchange_token(public_token.token)
    plaid_user = Argyle.plaid_client.set_user(exchange_token_response.access_token, ['connect'])
    
    # Database parsing & redirect
    @user = current_user
    Transaction.create_accounts(plaid_user.accounts, public_token, @user.id)
    Transaction.create_transactions(plaid_user.transactions)
    redirect_to @user
  end

  def update
    current_user.public_tokens.each do |t|
      if exchange_token_response = Argyle.plaid_client.exchange_token(t.token)
        updated_response = HTTParty.post('https://tartan.plaid.com/connect/get', :body => {"client_id" => ENV["CLIENT_ID"], "secret" => ENV["SECRET"], "access_token" => exchange_token_response.access_token})
        user_obj = Hashie::Mash.new(updated_response)
        Transaction.update_accounts(user_obj.accounts, t)
        Transaction.update_transactions(user_obj.transactions, @user)
      end
    end
    redirect_to @user
  end

  private
  def save_public_token(token)
    current_user.public_tokens << token
  end
end
