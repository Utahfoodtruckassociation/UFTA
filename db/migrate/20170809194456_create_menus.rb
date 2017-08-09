class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :title
      t.text :description
      t.text :food_image
      t.decimal :price
      t.references :truck, foreign_key: true

      t.timestamps
    end
  end
end
