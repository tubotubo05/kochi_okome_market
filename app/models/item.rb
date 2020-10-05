class Item < ApplicationRecord
  has_many :item_images, dependent: :destroy
  belongs_to :user
  belongs_to :category
  belongs_to :brand, optional: true
  #belongs_to_active_hash :prefecture
  #belongs_to_active_hash :condition
  #belongs_to_active_hash :shipping
  #belongs_to_active_hash :shipping_day

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
