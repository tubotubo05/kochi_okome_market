class UsersController < ApplicationController
  def show
    @items = Item.where(user_id: current_user.id).order(created_at: "DESC")
    @images = []
    @items.each do |item|
      @images.push([item, ItemImage.where(item_id: item[:id])])
    end
  end

  def email
  end

end
