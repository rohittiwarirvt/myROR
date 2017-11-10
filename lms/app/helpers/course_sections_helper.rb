module CourseSectionsHelper
  def course_section_name(chapter, course_section)
    return "Edit Section Name"  if chapter || course_section.section?
    return "Edit Chapter Name"
  end

  def cs_label(cs)
    return nil if cs.content?
    content_tag('div', '', class: 'cs-label', data: {cs_id: cs.id })
  end

  def edit_section_link(section)
    return link_to '', edit_version_course_section_path(section.version, section),
            remote: true, class: 'edit-btn' unless section.wrapped_content
    path = edit_content_path(section.wrapped_content)
    href = edit_presentation_path(path, section) ||
           edit_interactive_slide_link(section) ||
           send(path, section.version, section, section.wrapped_content)
    link_to '', href, class: 'edit-btn', remote: !section.content_resource.nil?
  end

  def edit_interactive_slide_link(section)
    return unless section.interactive_slide
    case section.interactive_slide.interactive_slide_type
    when localize('slide_text')
      new_version_course_section_interactive_slide_text_slide_path(section.version, section, section.interactive_slide)
    when localize('slide_image')
      new_version_course_section_interactive_slide_image_slide_path(section.version, section, section.interactive_slide)
    else
      new_version_course_section_interactive_slide_text_image_slide_path(section.version, section, section.interactive_slide)
    end
  end

  def edit_presentation_path(path, section)
    send(path, section.version, section, section.wrapped_content,
     section.wrapped_content.slides.first) if content_class(section.wrapped_content).eql?(CourseSection::CONTENT_TYPES[:presentation])
  end

  def edit_content_path(section)
    path_class = content_path(section, content_class(section))
    "edit_version_course_section_#{path_class}path"
  end

  def content_path(section, content)
    return edit_slide_path(section) if content.eql?(CourseSection::CONTENT_TYPES[:presentation])
  end

  def content_class(section)
    section.class.name.singularize.underscore
  end

  def edit_slide_path(section)
    "presentation_#{content_class(section.slides.first)}"
  end

  def course_evaluation_link
    version_evaluation_questions_path(@version)
  end

  def section_class(section)
    section.content ? 'content-section': ''
  end
end
