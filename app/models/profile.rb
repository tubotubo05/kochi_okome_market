class Profile < ApplicationRecord
  belongs_to :user, optional: true

  validates :first_name, :last_name, :kana_first_name, :kana_last_name, :birthday, presence: true
  
 
end
