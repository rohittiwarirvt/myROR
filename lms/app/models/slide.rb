class Slide < ApplicationRecord
  belongs_to :presentation
  has_many :slide_contents, dependent: :destroy
  has_one :slide_setting, dependent: :destroy
  accepts_nested_attributes_for :slide_contents, :slide_setting
  after_create :build_layout, :set_defaults


  def build_layout
    return if slide_contents.count > 0
    if number_of_columns > 1
      slide_contents << [LeftColumn.new, RightColumn.new]
    else
      slide_contents << [CenterColumn.new]
    end
  end

  def set_defaults
    return if slide_setting
    create_slide_setting(background_color: '#fff', transition: 'slideNone')
  end
end
