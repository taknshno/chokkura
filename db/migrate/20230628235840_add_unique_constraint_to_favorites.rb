class AddUniqueConstraintToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_index :favorites, [:user_id, :spot_id], unique: true
  end
end
