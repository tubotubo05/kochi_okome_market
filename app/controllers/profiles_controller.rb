class ProfilesController < ApplicationController
  def edit
    @profile = Profile.where(user_id: current_user.id)[0]
  end

  def update
    @profile = Profile.where(user_id: current_user.id)[0]
    if !@profile.update(profile_params)
      message = '入力されていない項目があるもしくは、”お名前(全角かな)”がひらがなで入力されていません'
      redirect_to edit_profile_path(current_user.id), flash: {error: message}
    else
      redirect_to edit_profile_path(current_user.id)
    end
  end


  private

  def profile_params
    if params[:profile][:"birthday(2i)"].length == 1
      params[:profile][:"birthday(2i)"] = "0" + params[:profile][:"birthday(2i)"]
    end
    if params[:profile][:"birthday(3i)"].length == 1
      params[:profile][:"birthday(3i)"] = "0" + params[:profile][:"birthday(3i)"]
    end
    birth = params[:profile][:"birthday(1i)"] + "-" + params[:profile][:"birthday(2i)"] + "-" + params[:profile][:"birthday(3i)"]
    params.require(:profile).permit(:first_name, :last_name, :kana_first_name, :kana_last_name).merge(birthday: birth)
  end

end
