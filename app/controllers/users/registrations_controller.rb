# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :authenticate_user!

  def index
  end
  # GET /resource/sign_up
  def new
    @user = User.new
    @profile = @user.build_profile
  end

  def new_destination
    redirect_to root_path
  end


  # POST /resource
  # def create
  #   @user = User.new(sign_up_params)
  #   unless @user.valid?
  #     flash.now[:alert] = @user.errors.full_messages
  #     render :new and return
  #   end
  #   session["devise.regist_data"] = {user: @user.attributes}
  #   session["devise.regist_data"][:user]["password"] = params[:user][:password]
  #   @profile = @user.build_profile
  #   render :new_profiles
  # end

  # def create_profile
  #   @user = User.new(session["devise.regist_data"]["user"])
  #   @profile = Profile.new(profile_params)
  #   unless @profile.valid?
  #     flash.now[:alert] = @profile.errors.full_messages
  #     render :new_profiles and return
  #   end
  #   @user.build_profile(@profile.attributes)
  #   @user.save
  #   session["devise.regist_data"]["user"].clear
  #   sign_in(:user, @user)
  # end

  def create
    @user = User.new(sign_up_params)
    @user.build_profile(sign_up_params[:profile_attributes])
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    session[:profile_attributes] = sign_up_params[:profile_attributes]
    @destination = @user.destinations.build
    render :new_destination
  end

  def create_destination
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = @user.build_profile(session[:profile_attributes])
    @destination = Destination.new(destination_params)
    unless @destination.valid?
      flash.now[:alert] = @destination.errors.full_messages
      render :new_destination and return
    end
    @user.destinations.build(@destination.attributes)
    @user.save
    @profile.save
    session["devise.regist_data"]["user"].clear
    session[:profile_attributes].clear
    sign_in(:user, @user)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def user_params
    params.require(:user).permit(:nickname, profile_attributes:[:first_name, :last_name, :kana_first_name, :kana_last_name, :birthday])
  end


  def destination_params
    params.require(:destination).permit(
      :first_name, :last_name, :kana_first_name, :kana_last_name, 
      :postal_code, :prefecture_id, :city, :address, 
      :additional_information, :phone_number)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end


end
