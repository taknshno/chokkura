module SpotsHelper
  def choose_new_or_edit
    if action_name == "new" || action_name == "create"
      confirm_spots_path
    elsif action_name == "edit"
      spot_path
    end
  end
end