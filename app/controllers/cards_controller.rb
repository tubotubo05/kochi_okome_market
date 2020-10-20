class CardsController < ApplicationController
  def index
    if current_user.cards != []
      @card = Card.get_card(current_user.cards[0].customer_token)
    end
  end

  def new
    @card = Card.new
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.create(card: params[:payjp_token])
    card = Card.new(customer_token: customer.id, user_id: current_user.id)
    #card.save ? (redirect_to :back) : (render :new)
    if card.save
      redirect_to cards_path
      #redirect_to request.referer
    else
      redirect_to new_card_path
    end
  end

  def destroy
    card = current_user.cards[0]
    if card.destroy
      redirect_to cards_path
    else
      redirect_to cards_path
    end
  end

end
