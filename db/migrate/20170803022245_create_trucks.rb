class CreateTrucks < ActiveRecord::Migration[5.0]
  def change
    create_table :trucks do |t|
      t.string :truck_name
      t.text :description
      t.text :main_image
      t.text :thumb_image

      t.timestamps
    end
  end
end
