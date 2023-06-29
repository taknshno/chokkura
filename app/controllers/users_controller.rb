class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :authorize_user

  def show
    # @favorites = current_user.favorites
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    unless @user == current_user then
      flash[:danger] = t('flash.permission_denied')
      redirect_to spots_path
    end
  end
end
