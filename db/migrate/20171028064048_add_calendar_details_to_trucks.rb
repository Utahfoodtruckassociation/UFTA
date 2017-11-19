class AddCalendarDetailsToTrucks < ActiveRecord::Migration[5.0]
  def change
    add_column :trucks, :calendar_id, :string
    add_column :trucks, :time_zone, :string
  end
end
