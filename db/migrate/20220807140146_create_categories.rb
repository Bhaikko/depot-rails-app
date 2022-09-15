class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.bigint :parent_id
      t.timestamps
      t.foreign_key :categories, column: "parent_id"
      t.index :name, unique: true
    end
  end
end
