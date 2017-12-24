class Course < ApplicationRecord
  has_many :versions, dependent: :destroy
  accepts_nested_attributes_for :versions

  class << self
    def published_versions
      Course.joins(:versions).where(versions: {published: true}).order(created_at: :desc)
    end
  end
end

