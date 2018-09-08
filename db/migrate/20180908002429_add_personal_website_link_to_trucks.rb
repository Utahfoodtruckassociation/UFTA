class AddPersonalWebsiteLinkToTrucks < ActiveRecord::Migration[5.0]
  def change
    add_column :trucks, :website, :string
  end
end
