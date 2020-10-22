class DestinationsController < ApplicationController
  def edit
    @destination = Destination.where(user_id: current_user.id)[0]
  end

  def update
    @destination = Destination.where(user_id: current_user.id)[0]
    if !@destination.update(destination_params)
      if params[:destination][:postal_code].length != 7
        message = '"郵便番号"が7文字の数字で入力されていません'
      else
        message = '"マンション名・部屋番号"、"電話番号"以外に入力されていない項目があるもしくは、"お名前(全角かな)"がひらがなで入力されていません'
      end
      redirect_to edit_destination_path(current_user.id), flash: {error: message}
    else
      redirect_to edit_destination_path(current_user.id)
    end
  end


  private

  def destination_params
    params.require(:destination).permit(:first_name, :last_name, :kana_first_name, :kana_last_name, :postal_code, 
    :prefecture_id, :city, :address, :additional_information, :phone_number)
  end
end
