class User < ActiveRecord::Base
  has_secure_password

  validates :password, length: { minimum: 8 }, allow_nil: true
  validates :email, uniqueness: true
  validates_format_of :email,:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  has_many :public_tokens
  has_many :accounts
  has_many :transactions, through: :accounts
  has_many :categories, through: :transactions
  has_many :budgets

  def total_debt
    if accounts.nil?
      ""
    else
      debt = 0.00
      accounts.each do |a|
        if a.acct_type == "credit"
          debt += a.current_balance
        end
      end
      return debt
    end
  end

  def total_cash
    if accounts.nil?
      ""
    else
      cash = 0.00
      accounts.each do |a|
        if a.acct_type == "depository"
          cash += a.current_balance
        end
      end
      return cash
    end
  end

  def weekly_spending
  end

  def monthly_spending
  end
  
end
