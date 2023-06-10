class ChangeDataTypeAreaOfSpots < ActiveRecord::Migration[6.1]
  def change
    change_column :spots, :area, :integer, using: 'area::integer'
  end
end
