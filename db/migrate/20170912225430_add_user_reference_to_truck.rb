class AddUserReferenceToTruck < ActiveRecord::Migration[5.0]
  def change
    add_reference :trucks, :user, foreign_key: true
  end
end
