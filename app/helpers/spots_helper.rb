module SpotsHelper
  def spot_choose_new_or_edit
    if action_name == "new" || action_name == "confirm"
      confirm_admin_spots_path
    elsif action_name == "edit"
      admin_spot_path
    end
  end
end