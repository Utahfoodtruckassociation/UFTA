class Truck < ApplicationRecord
	has_many :menus, dependent: :destroy
	belongs_to :user
	accepts_nested_attributes_for :menus,
																allow_destroy: true,
																reject_if: lambda { |attrs| attrs['title'].blank? }

	validates_presence_of :truck_name, :description

	mount_uploader :thumb_image, ImageUploader
	mount_uploader :main_image, ImageUploader
end
