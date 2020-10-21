class UsersController < ApplicationController

  def index
    redirect_to root_path
  end

  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to edit_user_path(current_user.id)
  end

  def show
    @items = Item.where(user_id: current_user.id).order(created_at: "DESC")
    @images = []
    @items.each do |item|
      @images.push([item, ItemImage.where(item_id: item[:id])])
    end
  end


  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end

end
