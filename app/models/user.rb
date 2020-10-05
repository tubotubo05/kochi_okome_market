class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, :password, presence: true

  has_one :profiles, dependent: :destroy
  has_many :destinations, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :cards, dependent: :destroy
  
  validates :nickname, presence: true, uniqueness: true

end
