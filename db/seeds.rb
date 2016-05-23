# Database initialization procedures: 
print "Note this will destroy ALL users, categories, and transactions. Only use for initial set up. Please type 'y' to continue. \n"
response = STDIN.gets.chomp.downcase

if response == 'y'
  User.destroy_all
  Transaction.destroy_all
  Category.destroy_all
  PlaidCategory.destroy_all

  Category.create_categories
  PlaidCategory.assign_categories
else
  exit
end