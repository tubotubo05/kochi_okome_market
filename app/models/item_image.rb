class ItemImage < ApplicationRecord
  mount_uploader :src, ImageUploader
  belongs_to :item

  validates :image_url, presence: true
end
