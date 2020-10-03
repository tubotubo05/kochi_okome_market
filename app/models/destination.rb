class Destination < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, :kana_first_name, :postal_code, :prefecture_id, :city, :address, :additional_information, :phone_number :ture
end
