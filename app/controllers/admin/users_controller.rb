class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  skip_before_action :if_not_admin, only: [:after_ensure]
  before_action :set_user, only: [:show, :control]

  def index
    @users = User.all
  end

  def show
  end

  def control
    case params[:act]
    when "grant"
      if @user[:admin] == true
        flash[:danger] = t('views.messages.already_admin')
      elsif @user.update_attribute(:admin, true)
        flash[:notice] = t('views.messages.grant_admin')
      else
        flash[:danger] = t('views.messages.change_admin_failed')
      end
      redirect_to admin_users_path
    when "ensure"
      if @user[:admin] == false
        flash[:danger] = t('views.messages.already_not_admin')
        redirect_to admin_users_path
      elsif @user.update_attribute(:admin, false)
        after_ensure
      else
        flash[:danger] = t('views.messages.change_admin_failed')
        redirect_to admin_users_path
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def if_not_admin
    unless current_user.admin? then
      flash[:danger] = t('flash.permission_denied')
      redirect_to root_path
    end
  end

  def after_ensure
    if @user.id == current_user.id && @user.admin == false
      redirect_to :root
    else
      redirect_to admin_users_path
    end
    flash[:notice] = I18n.t('views.messages.ensure_admin')
  end
end
