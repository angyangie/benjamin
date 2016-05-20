class AddDefaultColumnToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :default, :boolean, default: false
  end
end
