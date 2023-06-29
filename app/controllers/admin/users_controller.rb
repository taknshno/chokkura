class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  skip_before_action :if_not_admin, only: %i[after_ensure]
  before_action :set_user, only: %i[show control destroy]
  before_action :control_guest?, only: %i[control]

  def index
    @users = User.all
  end

  def show
  end

  def control
    case params[:act]
    when "grant"
      if @user[:admin] == true
        flash[:danger] = t('flash.already_admin')
      elsif @user.update_attribute(:admin, true)
        flash[:notice] = t('flash.grant_admin')
      else
        flash[:danger] = t('flash.change_admin_failed')
      end
      redirect_to admin_users_path
    when "ensure"
      if @user[:admin] == false
        flash[:danger] = t('flash.already_not_admin')
        redirect_to admin_users_path
      elsif @user.update_attribute(:admin, false)
        after_ensure
      else
        flash[:danger] = t('flash.change_admin_failed')
        redirect_to admin_users_path
      end
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = t('flash.deleted_user')
      redirect_to admin_users_index_path
    else
      flash[:danger] = t('flash.delete_user_failed')
      redirect_to admin_users_index_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def if_not_admin
    unless current_user.admin? then
      flash[:danger] = t('flash.permission_denied')
      redirect_to spots_path
    end
  end

  def after_ensure
    if @user.id == current_user.id && @user.admin == false
      redirect_to :root
    else
      redirect_to admin_users_path
    end
    flash[:notice] = t('flash.ensure_admin')
  end

  def control_guest?
    if ['guest@example.com', 'admin_guest@example.com'].include?(@user.email) then
      redirect_to admin_users_path
      flash[:danger] = t('flash.guest_account_cannot_update_or_delete')
    end
  end
end
