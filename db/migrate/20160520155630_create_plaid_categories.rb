class CreatePlaidCategories < ActiveRecord::Migration
  def change
    create_table :plaid_categories do |t|
      t.integer :plaid_cat_id
      t.integer :category_id
      t.timestamps null: false
    end
  end
end
