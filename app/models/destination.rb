class Destination < ApplicationRecord
  belongs_to :user, optional: true

  validates :first_name, :last_name, :kana_first_name, :kana_last_name, :postal_code, :prefecture_id, :city, :address, presence: true

  validates :postal_code, numericality: true, length: { is: 7 }
  validates :kana_first_name, :kana_last_name, presence: true, format: { with: /\A[\p{Hiragana}\p{blank}ー－]+\z/, message: 'はひらがなで入力して下さい。'}


end
