class UsersController < ApplicationController

  def index
    redirect_to root_path
  end

  def edit
  end

  def update
    if !current_user.update(user_params)
      if params[:user][:email] == "" || params[:user][:nickname] == ""
        message = 'ニックネームもしくはメールアドレスに何も入力されていません'
      else
        message = 'ニックネームもしくはメールアドレスがすでに存在しています'
      end
      redirect_to edit_user_path(current_user.id), flash: {error: message}
    else
      redirect_to edit_user_path(current_user.id)
    end
  end

  def show
    @items = Item.where(user_id: current_user.id).order(created_at: "DESC")
    @images = []
    @items.each do |item|
      @images.push([item, ItemImage.where(item_id: item[:id])])
    end
  end

  def bought_items
    @items = Item.where(buyer_id: current_user.id).order(created_at: "DESC")
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
