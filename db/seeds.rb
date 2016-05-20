Category.destroy_all
PlaidCategory.destroy_all

# top level categories
income = Category.create!(name: "Income", default: true)
expenses = Category.create!(name: "Expenses", default: true)
special = Category.create!(name: "Special", default: true)

#level two categories
discretionary = Category.create!(name: "Discretionary", parent: expenses, default: true)
recurring = Category.create!(name: "Fixed & Recurring", parent: expenses, default: true)
life = Category.create!(name: "Life", parent: expenses, default: true)
other = Category.create!(name: "Other Expenses", parent: expenses, default: true)
specialexp = Category.create!(name: "Special", parent: expenses, default: true)
variable = Category.create!(name: "Variable", parent: expenses, default: true)

#income categories
Category.create!(name: "Bonus", parent: income, default: true)
Category.create!(name: "Interest Income", parent: income, default: true)
Category.create!(name: "Other Income", parent: income, default: true)
Category.create!(name: "Reimbursements", parent: income, default: true)
Category.create!(name: "Salary", parent: income, default: true)

#special
Category.create!(name: "Benefits", parent: special, default: true)
Category.create!(name: "Loan", parent: special, default: true)
Category.create!(name: "Taxes", parent: special, default: true)
Category.create!(name: "Transfer", parent: special, default: true)


#discretionary level three
Category.create!(name: "Home", parent: discretionary, default: true)
Category.create!(name: "Shopping", parent: discretionary, default: true)
Category.create!(name: "Entertainment", parent: discretionary, default: true)
Category.create!(name: "Rental & Taxi", parent: discretionary, default: true)
Category.create!(name: "Cash", parent: discretionary, default: true)
Category.create!(name: "Other", parent: discretionary, default: true)

#recurring level three
Category.create!(name: "Cell Phone", parent: recurring, default: true)
Category.create!(name: "Insurance", parent: recurring, default: true)
Category.create!(name: "Rent & Mortgage", parent: recurring, default: true)
Category.create!(name: "Transportation", parent: recurring, default: true)
Category.create!(name: "TV & Internet", parent: recurring, default: true)
Category.create!(name: "Utilities", parent: recurring, default: true)

#life level three categories
Category.create!(name: "Charity & Community", parent: life, default: true)
Category.create!(name: "Gifts", parent: life, default: true)
Category.create!(name: "Trips", parent: life, default: true)
Category.create!(name: "Wedding", parent: life, default: true)

#other level three categories
Category.create!(name: "Adjustments", parent: other, default: true)
Category.create!(name: "Reimbursable Expenses", parent: other, default: true)
Category.create!(name: "Interest & Fees", parent: other, default: true)

#special
Category.create!(name: "Tag", parent: specialexp, default: true)

#variable level three
Category.create!(name: "Cars & Vehicles", parent: variable, default: true)
Category.create!(name: "Children", parent: variable, default: true)
Category.create!(name: "Cleaning Supplies & Maids", parent: variable, default: true)
Category.create!(name: "Education", parent: variable, default: true)
Category.create!(name: "Fitness & Recreation", parent: variable, default: true)
Category.create!(name: "Healthcare", parent: variable, default: true)
Category.create!(name: "Laundry", parent: variable, default: true)
Category.create!(name: "Personal Care", parent: variable, default: true)
Category.create!(name: "Pets", parent: variable, default: true)


food = Category.create!(name: "Total Food", parent: variable, default: true)
Category.create!(name: "Alcohol & Bars", parent: food, default: true)
Category.create!(name: "Coffee Shops", parent: food, default: true)
Category.create!(name: "Fast Food & Delivery", parent: food, default: true)
Category.create!(name: "Groceries", parent: food, default: true)
Category.create!(name: "Other Food", parent: food, default: true)
Category.create!(name: "Restaurants", parent: food, default: true)
Category.create!(name: "Work Meals", parent: food, default: true)


plaid_category_ids = [10000000, 10001000, 10002000, 10003000, 10004000, 10005000, 10006000, 10007000, 10008000, 10009000, 11000000, 12000000, 12001000, 12002000, 12002001, 12002002, 12003000, 12004000, 12005000, 12006000, 12007000, 12008000, 12008001, 12008002, 12008003, 12008004, 12008005, 12008006, 12008007, 12008008, 12008009, 12008010, 12008011, 12009000, 12010000, 12011000, 12012000, 12012001, 12012002, 12012003, 12013000, 12014000, 12015000, 12015001, 12015002, 12015003, 12016000, 12017000, 12018000, 12018001, 12018002, 12018003, 12018004, 12019000, 12019001, 13000000, 13001000, 13001001, 13001002, 13001003, 13002000, 13003000, 13004000, 13004001, 13004002, 13004003, 13004004, 13004005, 13004006, 13005000, 13005001, 13005002, 13005003, 13005004, 13005005, 13005006, 13005007, 13005008, 13005009, 13005010, 13005011, 13005012, 13005013, 13005014, 13005015, 13005016, 13005017, 13005018, 13005019, 13005020, 13005021, 13005022, 13005023, 13005024, 13005025, 13005026, 13005027, 13005028, 13005029, 13005030, 13005031, 13005032, 13005033, 13005034, 13005035, 13005036, 13005037, 13005038, 13005039, 13005040, 13005041, 13005042, 13005043, 13005044, 13005045, 13005046, 13005047, 13005048, 13005049, 13005050, 13005051, 13005052, 13005053, 13005054, 13005055, 13005056, 13005057, 13005058, 13005059, 14000000, 14001000, 14001001, 14001002, 14001003, 14001004, 14001005, 14001006, 14001007, 14001008, 14001009, 14001010, 14001011, 14001012, 14001013, 14001014, 14001015, 14001016, 14001017, 14002000, 14002001, 14002002, 14002003, 14002004, 14002005, 14002006, 14002007, 14002008, 14002009, 14002010, 14002011, 14002012, 14002013, 14002014, 14002015, 14002016, 14002017, 14002018, 14002019, 14002020, 15000000, 15001000, 15002000, 16000000, 16001000, 16002000, 16003000, 17000000, 17001000, 17001001, 17001002, 17001003, 17001004, 17001005, 17001006, 17001007, 17001008, 17001009, 17001010, 17001011, 17001012, 17001013, 17001014, 17001015, 17001016, 17001017, 17001018, 17001019, 17002000, 17003000, 17004000, 17005000, 17006000, 17007000, 17008000, 17009000, 17010000, 17011000, 17012000, 17013000, 17014000, 17015000, 17016000, 17017000, 17018000, 17019000, 17020000, 17021000, 17022000, 17023000, 17023001, 17023002, 17023003, 17023004, 17024000, 17025000, 17025001, 17025002, 17025003, 17025004, 17025005, 17026000, 17027000, 17027001, 17027002, 17027003, 17028000, 17029000, 17030000, 17031000, 17032000, 17033000, 17034000, 17035000, 17036000, 17037000, 17038000, 17039000, 17040000, 17041000, 17042000, 17043000, 17044000, 17045000, 17046000, 17047000, 17048000, 18000000, 18001000, 18001001, 18001002, 18001003, 18001004, 18001005, 18001006, 18001007, 18001008, 18001009, 18001010, 18003000, 18004000, 18005000, 18006000, 18006001, 18006002, 18006003, 18006004, 18006005, 18006006, 18006007, 18006008, 18006009, 18007000, 18008000, 18008001, 18009000, 18010000, 18011000, 18012000, 18012001, 18012002, 18013000, 18013001, 18013002, 18013003, 18013004, 18013005, 18013006, 18013007, 18013008, 18013009, 18013010, 18014000, 18015000, 18016000, 18017000, 18018000, 18018001, 18019000, 18020000, 18020001, 18020002, 18020003, 18020004, 18020005, 18020006, 18020007, 18020008, 18020009, 18020010, 18020011, 18020012, 18020013, 18020014, 18021000, 18021001, 18021002, 18022000, 18023000, 18024000, 18024001, 18024002, 18024003, 18024004, 18024005, 18024006, 18024007, 18024008, 18024009, 18024010, 18024011, 18024012, 18024013, 18024014, 18024015, 18024016, 18024017, 18024018, 18024019, 18024020, 18024021, 18024022, 18024023, 18024024, 18024025, 18024026, 18024027, 18025000, 18026000, 18027000, 18028000, 18029000, 18030000, 18031000, 18032000, 18033000, 18034000, 18035000, 18036000, 18037000, 18037001, 18037002, 18037003, 18037004, 18037005, 18037006, 18037007, 18037008, 18037009, 18037010, 18037011, 18037012, 18037013, 18037014, 18037015, 18037016, 18037017, 18037018, 18037019, 18037020, 18038000, 18039000, 18040000, 18040001, 18040002, 18040003, 18041000, 18042000, 18043000, 18044000, 18045000, 18045001, 18045002, 18045003, 18045004, 18045005, 18045006, 18045007, 18045008, 18045009, 18045010, 18046000, 18047000, 18048000, 18049000, 18050000, 18050001, 18050002, 18050003, 18050004, 18050005, 18050006, 18050007, 18050008, 18050009, 18050010, 18051000, 18052000, 18053000, 18054000, 18055000, 18056000, 18057000, 18058000, 18059000, 18060000, 18061000, 18062000, 18063000, 18064000, 18065000, 18066000, 18067000, 18068000, 18068001, 18068002, 18068003, 18068004, 18068005, 18069000, 18070000, 18071000, 18072000, 18073000, 18073001, 18073002, 18073003, 18073004, 18074000, 19000000, 19001000, 19002000, 19003000, 19004000, 19005000, 19005001, 19005002, 19005003, 19005004, 19005005, 19005006, 19005007, 19006000, 19007000, 19008000, 19009000, 19010000, 19011000, 19012000, 19012001, 19012002, 19012003, 19012004, 19012005, 19012006, 19012007, 19012008, 19013000, 19013001, 19013002, 19013003, 19014000, 19015000, 19016000, 19017000, 19018000, 19019000, 19020000, 19021000, 19022000, 19023000, 19024000, 19025000, 19025001, 19025002, 19025003, 19025004, 19026000, 19027000, 19028000, 19029000, 19030000, 19031000, 19032000, 19033000, 19034000, 19035000, 19036000, 19037000, 19038000, 19039000, 19040000, 19040001, 19040002, 19040003, 19040004, 19040005, 19040006, 19040007, 19040008, 19041000, 19042000, 19043000, 19044000, 19045000, 19046000, 19047000, 19048000, 19049000, 19050000, 19051000, 19052000, 19053000, 19054000, 20000000, 20001000, 20002000, 21000000, 21001000, 21002000, 21003000, 21004000, 21005000, 21006000, 21007000, 21007001, 21007002, 21008000, 21009000, 21009001, 21010000, 21010001, 21010002, 21010003, 21010004, 21010005, 21010006, 21010007, 21010008, 21010009, 21010010, 21011000, 21012000, 21012001, 21012002, 21013000, 22000000, 22001000, 22002000, 22003000, 22004000, 22005000, 22006000, 22006001, 22007000, 22008000, 22009000, 22010000, 22011000, 22012000, 22012001, 22012002, 22012003, 22012004, 22012005, 22012006, 22013000, 22014000, 22015000, 22016000, 22017000, 22018000]
category_names = ['Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Loan', 'Charity & Community', 'Pets', 'Healthcare', 'Healthcare', 'Healthcare', 'Other', 'Other', 'Children', 'Healthcare', 'Healthcare', 'Education', 'Education', 'Education', 'Education', 'Education', 'Education', 'Education', 'Education', 'Education', 'Education', 'Education', 'Education', 'Other', 'Other', 'Charity & Community', 'Other', 'Other', 'Other', 'Other', 'Education', 'Other', 'Charity & Community', 'Charity & Community', 'Charity & Community', 'Charity & Community', 'Other', 'Other', 'Charity & Community', 'Charity & Community', 'Charity & Community', 'Charity & Community', 'Charity & Community', 'Healthcare', 'Healthcare', 'Other Food', 'Alcohol & Bars', 'Alcohol & Bars', 'Alcohol & Bars', 'Alcohol & Bars', 'Alcohol & Bars', 'Coffee Shops', 'Alcohol & Bars', 'Alcohol & Bars', 'Alcohol & Bars', 'Alcohol & Bars', 'Alcohol & Bars', 'Alcohol & Bars', 'Alcohol & Bars', 'Restaurants', 'Alcohol & Bars', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Fast Food & Delivery', 'Fast Food & Delivery', 'Restaurants', 'Fast Food & Delivery', 'Restaurants', 'Restaurants', 'Restaurants', 'Fast Food & Delivery', 'Alcohol & Bars', 'Restaurants', 'Restaurants', 'Fast Food & Delivery', 'Fast Food & Delivery', 'Restaurants', 'Coffee Shops', 'Restaurants', 'Restaurants', 'Restaurants', 'Coffee Shops', 'Fast Food & Delivery', 'Fast Food & Delivery', 'Restaurants', 'Restaurants', 'Restaurants', 'Coffee Shops', 'Coffee Shops', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Restaurants', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Healthcare', 'Interest & Fees', 'Interest Income', 'Interest & Fees', 'Other', 'Transfer', 'Rent & Mortgage', 'Loan', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Entertainment', 'Fitness & Recreation', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Entertainment', 'Entertainment', 'Entertainment', 'Entertainment', 'Fitness & Recreation', 'Entertainment', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Entertainment', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Fitness & Recreation', 'Entertainment', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Entertainment', 'Entertainment', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Other', 'Other', 'Other', 'TV & Internet', 'Other', 'Cleaning Supplies & Maids', 'Shopping', 'Shopping', 'Shopping', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Other', 'Entertainment', 'Other', 'Other', 'Entertainment', 'Entertainment', 'Entertainment', 'Other', 'Other', 'Other Income', 'Interest & Fees', 'Loan', 'Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Interest & Fees', 'Other', 'Interest & Fees', 'Other', 'Other Food', 'Other Food', 'Other Food', 'Other', 'Other', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Home', 'Other', 'Other', 'Other', 'Other', 'Insurance', 'TV & Internet', 'Shopping', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Entertainment', 'Cars & Vehicles', 'Other', 'Other', 'Personal Care', 'Personal Care', 'Personal Care', 'Personal Care', 'Personal Care', 'Personal Care', 'Healthcare', 'Personal Care', 'Laundry', 'Personal Care', 'Personal Care', 'Cars & Vehicles', 'Entertainment', 'Other', 'Other', 'Home', 'Home', 'Home', 'Home', 'Home', 'Rent & Mortgage', 'Home', 'Home', 'Rent & Mortgage', 'Rent & Mortgage', 'Rent & Mortgage', 'Other', 'Utilities', 'Shopping', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Rent & Mortgage', 'Entertainment', 'Shopping', 'Cell Phone', 'Other', 'Trips', 'Transportation', 'Trips', 'Utilities', 'Utilities', 'Utilities', 'Utilities', 'Utilities', 'Utilities', 'Pets', 'Utilities', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Other', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Cars & Vehicles', 'Personal Care', 'Shopping', 'Cars & Vehicles', 'Shopping', 'Shopping', 'Children', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Home', 'Personal Care', 'Shopping', 'Entertainment', 'Shopping', 'Entertainment', 'Shopping', 'Shopping', 'Other', 'Shopping', 'Shopping', 'Groceries', 'Groceries', 'Groceries', 'Groceries', 'Alcohol & Bars', 'Cars & Vehicles', 'Shopping', 'Shopping', 'Healthcare', 'Home', 'Shopping', 'Other', 'Shopping', 'Shopping', 'Cars & Vehicles', 'Entertainment', 'Shopping', 'Entertainment', 'Other', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Shopping', 'Pets', 'Personal Care', 'Shopping', 'Shopping', 'Fitness & Recreation', 'Groceries', 'Alcohol & Bars', 'Shopping', 'Shopping', 'Shopping', 'Wedding', 'Shopping', 'Home', 'Taxes', 'Other Income', 'Taxes', 'Transfer', 'Transfer', 'Transfer', 'Other', 'Other', 'Other', 'Other', 'Other Income', 'Other Income', 'Other Income', 'Transfer', 'Salary', 'Benefits', 'Tag', 'Tag', 'Tag', 'Tag', 'Tag', 'Tag', 'Tag', 'Tag', 'Tag', 'Tag', 'Tag', 'Tag', 'Cash', 'Cash', 'Cash', 'Transfer', 'Trips', 'Trips', 'Trips', 'Transportation', 'Trips', 'Rental & Taxi', 'Rental & Taxi', 'Rental & Taxi', 'Transportation', 'Trips', 'Cars & Vehicles', 'Transportation', 'Rental & Taxi', 'Trips', 'Trips', 'Trips', 'Trips', 'Trips', 'Trips', 'Trips', 'Cars & Vehicles', 'Transportation', 'Transportation', 'Rental & Taxi', 'Cars & Vehicles', 'Transportation']

def assign_categories(plaid_category_ids, category_names)
  x = 0

  while x < plaid_category_ids.length do
    p = PlaidCategory.create(plaid_cat_id: plaid_category_ids[x])
    p.category = Category.find_by(name: category_names[x])
    p.save
    x += 1
  end
end

assign_categories(plaid_category_ids, category_names)

