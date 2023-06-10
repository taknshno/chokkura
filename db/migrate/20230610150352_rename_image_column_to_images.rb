class RenameImageColumnToImages < ActiveRecord::Migration[6.1]
  def change
    change_column :spots, :image, :json, using: 'image::json'
    rename_column :spots, :image, :images
  end
end
