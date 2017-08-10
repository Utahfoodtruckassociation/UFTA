class Truck < ApplicationRecord
	has_many :menus, dependent: :destroy
	accepts_nested_attributes_for :menus,
																allow_destroy: true,
																reject_if: lambda { |attrs| attrs['title'].blank? }

	validates_presence_of :truck_name, :description
end
