#require 'lib/modules/resource_collection'
class Resource < ApplicationRecord
  belongs_to :version

  TYPES = {
    video: 'Video',
    document: 'Document',
    quote: 'Quote',
    note: 'Note',
  }

  include RankedModel
  include ResourceCollection

  ranks :chapter_order, with_same: :course_section_id
  ranks :version_order, with_same: :version_id

  def self.valid_type?(type)
    return false if type.nil?
    ResourceCollection::valid_types.include?(type)
  end

  def self.upload?(type)
    return false if type.nil?
    [TYPES[:video], TYPES[:document]].include?(type)
  end

  def text_resource?(type)
    return false if type.nil?
    [TYPES[:quote], TYPES[:note]].include?(type)
  end
end
