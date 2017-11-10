class SlideContent < ApplicationRecord
  belongs_to :slide
  self.inheritance_column = :orientation
  mount_uploader :file_url, SlideMediaUploader
end
