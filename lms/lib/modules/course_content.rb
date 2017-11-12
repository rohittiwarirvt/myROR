module CourseContent
  ASSOC_OPTS = { foreign_key: :course_section_id}

  def sectionize_content(opts = ASSOC_OPTS)
    section = CourseSection.new
    section.version_id = course_section.version_id
    section.parent_id = course_section_id
    section.name = content_section_name
    section.content = true
    section.save
    update_attribute(opts[:foreign_key], section.id)
    redirect_section(opts[:foreign_key])
  end

  def update_section
    section_wrapper.name=content_section_name
    section_wrapper.save!
  end

  def section_wrapper
    try(:content_section) || try(:course_section)
  end

  def redirect_section(key)
    return if key.eql?(:course_section_id) || !respond_to?(:course_section_id)
    update_attribute(:course_section_id, nil)
  end

  def content_section_name
    section_name = try(:name) || try(:title)
    "#{transform_type}: #{section_name}"
  end

  def transform_type
    self.class.name.underscore.humanize.split.map(&:capitalize).join(' ')
  end
end
