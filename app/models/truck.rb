class Truck < ApplicationRecord
	has_many :menus, dependent: :destroy
	belongs_to :user, required: true
	accepts_nested_attributes_for :menus,
																allow_destroy: true,
																reject_if: lambda { |attrs| attrs['title'].blank? }

	validates_presence_of :truck_name, :description, :food_type

	mount_uploader :thumb_image, ImageUploader
	mount_uploader :main_image, ImageUploader

	def self.search(search)
  	where("truck_name ILIKE ? OR description ILIKE ?", "%#{search}%", "%#{search}%") 
	end

	def self.dropdown(dropdown)
		where(food_type: dropdown.values)
	end
end
