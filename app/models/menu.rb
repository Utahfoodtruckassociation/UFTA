class Menu < ApplicationRecord
  belongs_to :truck

  mount_uploader :food_image, ImageUploader
end
