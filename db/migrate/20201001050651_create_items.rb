class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|

      t.string :email, null: false, default: ""

      t.string :name, null: false
      t.integer :price, null: false
      t.text :description, null: false
      t.integer :prefecture_id, null: false
      category_id	references	null: false, foreign_key: true
      brand_id	references	foreign_key: true
      condition_id	integer	null: false
      shipping_id	integer	null: false
      shipping_day_id	integer	null: false
      buyer_id	references	foreign_key: true
      user_id	references	null: false, foreign_key: true

      t.timestamps
    end
  end
end
