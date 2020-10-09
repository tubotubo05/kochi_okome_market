class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text :description, null: false
      t.integer :prefecture_id, null: false
      t.references :category, null: false, foreign_key: true
      t.references :brand, foreign_key: true
      t.integer :condition_id, null: false
      t.integer :shipping_id, null: false
      t.integer :shipping_day_id, null: false
      t.references :buyer, foreign_key: { to_table: :users }
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
