module ResourcesHelper
  def description_label
    return if @type.eql? Resource::TYPES[:document]
    label_tag :description, localize(:description_title), class: 'chapter-name'
  end

  def description_field
    return :hidden_field if @type.eql? Resource::TYPES[:document]
    :text_area
  end

  def chapter_tag(section)
    return if section.section?
    tag(:div, {id: 'chapter-content-form', data: {chapter_id: section.id}})
  end
end
