class ChangeNotDefaultToSpots < ActiveRecord::Migration[6.1]
  def change
    change_column_default :spots, :phone, from: "未掲載", to: nil
    change_column_default :spots, :holiday, from: "未掲載", to: nil
  end
end
