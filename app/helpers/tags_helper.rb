module TagsHelper
  def tag_choose_new_or_edit
    if action_name == "new" || action_name == "confirm"
      puts
      puts
      puts "+++++++++++++"
      puts confirm_admin_tags_path
      puts
      confirm_admin_tags_path
    elsif action_name == "edit"
      admin_tag_path
    end
  end
end