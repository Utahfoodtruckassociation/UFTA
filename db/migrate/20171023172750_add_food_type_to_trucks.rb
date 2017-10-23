class AddFoodTypeToTrucks < ActiveRecord::Migration[5.0]
  def change
    add_column :trucks, :food_type, :text
  end
end
