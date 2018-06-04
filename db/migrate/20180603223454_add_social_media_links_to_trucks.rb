class AddSocialMediaLinksToTrucks < ActiveRecord::Migration[5.0]
  def change
    add_column :trucks, :facebook, :string
    add_column :trucks, :instagram, :string
    add_column :trucks, :twitter, :string
  end
end
