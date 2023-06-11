class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.string :name,   null: false
      t.string :image
      t.string :area,   null: false
      t.string :address,   null: false
      t.string :phone
      t.string :holiday
      t.string :sales_copy
      t.text :detail_description,   null: false
      t.string :simple_description
      t.timestamps
    end
  end
end
