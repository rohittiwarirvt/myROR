class Course < ActiveRecord::Base
  has_many :versions, dependent: :destroy
  accepts_nested_attributes_for :versions
end
