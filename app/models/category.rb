class Category < ActiveRecord::Base
  has_ltree_hierarchy
  has_many :plaid_categories
  
end
