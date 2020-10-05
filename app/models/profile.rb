class Profile < ApplicationRecord
  belongs_to :user, optional: true

  validates :first_name, presence: true, uniqueness: true
  validates :last_name, presence: true
  validates :kana_first_name, presence: true
  validates :kana_last_name, presence: true

end
