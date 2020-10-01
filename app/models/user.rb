class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #has_one :profiles, dependent: :destroy
  #has_many :destinations, dependent: :destroy
  #has_many :credit_cards, dependent: :destroy
  #has_many :items, dependent: :destroy
end
