class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|

      t.string :first_name,		      null: false
      t.string :last_name,		      null: false
      t.string :kana_first_name,		null: false
      t.string :kana_last_name,		  null: false
      t.string :postal_code,		    null: false
      t.integer :prefecture_id,	    null: false
      t.string :city,               null: false
      t.string :address,		        null: false
      t.string :additional_information		
      t.string :phone_number		
      t.references :user,		        null: false, foreign_key: true


      t.timestamps
    end
  end
end
