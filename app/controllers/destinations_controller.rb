class DestinationsController < ApplicationController
  def edit
    @destination = Destination.where(user_id: current_user.id)[0]
  end

  def update
    @destination = Destination.where(user_id: current_user.id)[0]
    @destination.update(destination_params)
    redirect_to edit_destination_path(current_user.id)
  end


  private

  def destination_params
    params.require(:destination).permit(:first_name, :last_name, :kana_first_name, :kana_last_name, :postal_code, 
    :prefecture_id, :city, :address, :additional_information, :phone_number)
  end
end
