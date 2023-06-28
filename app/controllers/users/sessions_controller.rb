class Users::SessionsController < Devise::SessionsController
  def common_guest_sign_in
    user = User.common_guest
    sign_in user
    redirect_to spots_path
    flash[:notice] = t('flash.guest_logged_in_as_common_user')
  end

  def admin_guest_sign_in
    user = User.admin_guest
    sign_in user
    redirect_to spots_path
    flash[:notice] = t('flash.guest_logged_in_as_admin_user')
  end
end
