class ChangeDataTypeLocationOfUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :location, :integer, using: 'location::integer'
  end
end
