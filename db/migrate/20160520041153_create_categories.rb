class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      enable_extension "ltree"
      t.string :name
      t.integer :parent_id
      t.ltree :path
      t.timestamps null: false
    end
  end
end
