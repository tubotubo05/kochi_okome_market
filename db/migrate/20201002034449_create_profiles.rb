class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :first_name,		      null: false
      t.string :last_name,		      null: false
      t.string :kana_first_name,		null: false
      t.string :kana_last_name,		  null: false
      t.date :birthday,		          null: false
      t.references :user,		        null: false, foreign_key: true


      t.timestamps
    end
  end
end
