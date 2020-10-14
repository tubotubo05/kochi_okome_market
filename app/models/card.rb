class Card < ApplicationRecord
  belongs_to :user

  def self.get_card(customer_token)
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(customer_token)
    card_data = customer.cards.first
  end
end
