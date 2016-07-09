class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name
      t.datetime :purchase_date
      t.string :product_url
      t.integer :price
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
