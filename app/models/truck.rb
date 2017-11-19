class Truck < ApplicationRecord
	has_many :menus, dependent: :destroy
	belongs_to :user, required: true
	accepts_nested_attributes_for :menus,
																allow_destroy: true,
																reject_if: lambda { |attrs| attrs['title'].blank? }

	validates_presence_of :truck_name, :description, :food_type, :calendar_id, :time_zone

	mount_uploader :thumb_image, ImageUploader
	mount_uploader :main_image, ImageUploader

	def self.search(search)
  	joins(:menus).where("trucks.truck_name ILIKE ? OR trucks.description ILIKE ? OR menus.title ILIKE ? OR menus.description ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
	end

	def self.dropdown(dropdown)
		where(food_type: dropdown.values)
	end
end
