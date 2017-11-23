class SlideSetting < ApplicationRecord
  belongs_to :slide
  mount_uploader :background_image, ImageUploader
end
