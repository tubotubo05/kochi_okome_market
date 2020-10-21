class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, :password, presence: true

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  has_many :destinations, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  

  def already_liked?(item)
    self.likes.exists?(item_id: item.id)
  end


end
