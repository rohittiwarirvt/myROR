class Slide < ApplicationRecord
  belongs_to : presentation
  has_many : slide_contents, dependent: :destroy
  has_one : slide_settings, dependent: :destroy
end
