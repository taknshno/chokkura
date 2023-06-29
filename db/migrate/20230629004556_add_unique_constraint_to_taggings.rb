class AddUniqueConstraintToTaggings < ActiveRecord::Migration[6.1]
  def change
    add_index :taggings, [:spot_id, :tag_id], unique: true
  end
end
