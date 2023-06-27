# crumb :root do
#   link "Home", root_path
# end

crumb :root do
  link "Home", spots_path
end

crumb :spot_show do |spot|
  link "#{spot.name}", spot_path(spot)
  parent :root
end

crumb :user_show do |user|
  link t('views.messages.user_profile'), user_path(user)
  parent :root
end

crumb :edit_user do |user|
  link t('views.title.edit_user_info'), edit_user_registration_path
  parent :user_show, user
end

crumb :admin_index do
  link t('views.messages.admin_menu'), admin_index_path
  parent :root
end

crumb :admin_users do
  link t('views.messages.users_index'), admin_users_path
  parent :admin_index
end

crumb :admin_spots do
  link t('views.messages.spots_index'), admin_spots_path
  parent :admin_index
end

crumb :new_admin_spot do
  link t('views.messages.register_spot'), new_admin_spot_path
  parent :admin_index
end

crumb :edit_admin_spot do
  link t('views.messages.edit_spot'), edit_admin_spot_path
  parent :admin_spots
end

crumb :admin_tags do
  link t('views.messages.tags_index'), admin_tags_path
  parent :admin_index
end

crumb :new_admin_tag do
  link t('views.messages.create_tag'), new_admin_tag_path
  parent :admin_index
end

crumb :edit_admin_tag do
  link t('views.messages.create_tag'), edit_admin_tag_path
  parent :admin_tags
end