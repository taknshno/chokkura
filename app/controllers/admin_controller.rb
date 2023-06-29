class AdminController < ApplicationController
  before_action :if_not_admin

  def index
  end

  def if_not_admin
    unless current_user.admin? then
      flash[:danger] = t('flash.permission_denied')
      redirect_to spots_path
    end
  end
end
