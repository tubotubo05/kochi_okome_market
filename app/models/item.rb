class Item < ApplicationRecord
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true
  belongs_to :user
  belongs_to :category
  belongs_to :brand, optional: true
  has_many :comments, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping
  belongs_to_active_hash :shipping_day

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 1 }
  validate  :image_lists_validation

  def image_lists_validation
    image_validation = item_images
    if image_validation.length < 1 then
      errors.add(:item_images, "画像を１枚以上添付してください")
    elsif image_validation.length > 5
      errors.add(:item_images, "画像は５枚まで添付可能です")
    end
  end
  
end
