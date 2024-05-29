class UserSettingsController < ApplicationController
  before_action :set_user_setting, only: :update

  # GET /user_settings or /user_settings.json
  def index
    @user_settings = current_user.user_setting
  end

  # PATCH/PUT /user_settings/1 or /user_settings/1.json
  def update
    respond_to do |format|
      if @user_setting.update(user_setting_params)
        format.html { redirect_to user_settings_path, notice: "User setting was successfully updated." }
        format.json { render :show, status: :ok, location: @user_setting }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @user_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user_setting
      @user_setting = current_user.user_setting
    end

    # Only allow a list of trusted parameters through.
    def user_setting_params
      params.fetch(:user_setting, {}).permit([:fiat_currency_id, :time_zone])
    end
end
