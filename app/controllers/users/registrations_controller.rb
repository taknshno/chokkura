class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_guest, only: %i[update destroy]

  def ensure_guest
    if ['guest@example.com', 'admin_guest@example.com'].include?(resource.email) then
      redirect_to spots_path
      flash[:danger] = t('flash.guest_account_cannot_update_or_delete')
    end
  end

  protected

  def after_update_path_for(resource)
    user_path(current_user)
  end
end
