class ChangeColumnDefaultToSpots < ActiveRecord::Migration[6.1]
  def change
    change_column_default :spots, :phone, from: nil, to: "未掲載"
    change_column_default :spots, :holiday, from: nil, to: "未掲載"
  end
end
