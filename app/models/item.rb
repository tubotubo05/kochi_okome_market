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

  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 300,  :less_than => 10000000}

  validate  :image_lists_validation

  def image_lists_validation
    delete_count = 0
    item_images.each do |img|
      if img.marked_for_destruction?
        delete_count += 1
      end
    end
    validation_num = item_images.length - delete_count
    if validation_num < 1 then
      errors.add(:item_images, "画像を１枚以上添付してください")
    elsif validation_num > 5
      errors.add(:item_images, "画像は５枚まで添付可能です")
    end
  end
  
end
