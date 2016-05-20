class Transaction < ActiveRecord::Base
  self.primary_key = 'plaid_trans_id'
  belongs_to :account
  belongs_to :category
  delegate :user, :to => :account
end
